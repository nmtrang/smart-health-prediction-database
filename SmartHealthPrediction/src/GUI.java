import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;

public class GUI {
    private String host;
    private String instance;
    private final String url = "jdbc:sqlserver://" + host + "\\" + instance + ";database=SmartHealthPrediction;integratedSecurity=true;";
    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;
    {
        try {
            connection = DriverManager.getConnection(url);
            statement = connection.createStatement();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }

    private JFrame homeFrame = new JFrame("HOME");
    private JFrame loginFrame = new JFrame("LOGIN");

    public GUI() {
        setHomeFrame();
    }

    public void setHomeFrame() {
        this.homeFrame.setLayout(new GridLayout(1, 3));
        homeFrame.getContentPane().setBackground(Color.PINK);

        JButton admin = new JButton("Admin");
        admin.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                homeFrame.dispose();
                setLoginFrame(admin.getActionCommand());
            }
        });

        JButton patient = new JButton("Patient");
        patient.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                homeFrame.dispose();
                setLoginFrame(patient.getActionCommand());
            }
        });

        JButton doctor = new JButton("Doctor");
        doctor.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                homeFrame.dispose();
                setLoginFrame(doctor.getActionCommand());
            }
        });

        homeFrame.add(admin);
        homeFrame.add(patient);
        homeFrame.add(doctor);

        homeFrame.pack();
        homeFrame.setLocationRelativeTo(null);
        homeFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        homeFrame.setVisible(true);
    }

    public void setLoginFrame(String loginType) {
        this.loginFrame.setLayout(new GridLayout(3, 2));

        loginFrame.add(new JLabel("Username:"));
        JTextField userField = new JTextField();
        loginFrame.add(userField);

        loginFrame.add(new JLabel("Password:"));
        JPasswordField pwField = new JPasswordField();
        loginFrame.add(pwField);

        JButton logIn = new JButton("Log in");
        logIn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String user = userField.getText();
                String pw = String.valueOf(pwField.getPassword());
                int log = 0;
                try {
                    resultSet = statement.executeQuery("SELECT * FROM " + loginType + "Login");

                    while (resultSet.next()) {
                        if (resultSet.getString(1).equals(user) && resultSet.getString(2).equals(pw)) {
                            System.out.println("Logged in");
                            log = 1;
                            break;
                        }
                    }
                }
                catch (SQLException ex) {
                    ex.printStackTrace();
                }

                if (log == 0)
                    JOptionPane.showMessageDialog(null, "Incorrect credentials.");
                else
                    JOptionPane.showMessageDialog(null, "Success.");
            }
        });
        loginFrame.add(logIn);

        JButton cancel = new JButton("Cancel");
        loginFrame.add(cancel);

        loginFrame.pack();
        loginFrame.setLocationRelativeTo(null);
        loginFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        loginFrame.setVisible(true);
    }
}
