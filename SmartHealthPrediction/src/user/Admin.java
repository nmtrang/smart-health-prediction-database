package user;

import disease.Disease;
import disease.Specialty;
import disease.Symptom;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.JTableHeader;
import javax.swing.table.TableColumnModel;
import java.awt.*;
import java.sql.SQLException;
import java.util.ArrayList;

public class Admin extends User {
    public Admin(String username, String password) {
        super(username, password);
    }

    public JPanel viewDoctors() {
        JPanel panel = new JPanel();
        panel.setBackground(Color.BLACK);
        panel.setLayout(new GridBagLayout());

        ArrayList<String[]> data = new ArrayList<>();
        try {
            resultSet = statement.executeQuery("select * from Doctor");

            while (resultSet.next()) {
                String[] row = {String.valueOf(resultSet.getInt(1)),
                        resultSet.getString(10).trim(),
                        resultSet.getString(2).trim() + " " + resultSet.getString(3).trim() + " " + resultSet.getString(4).trim(),
                        resultSet.getString(5).trim(), resultSet.getString(6).trim(), resultSet.getString(7).trim(),
                        resultSet.getString(8).trim(), String.valueOf(resultSet.getInt(9))
                };
                data.add(row);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        for (int i = 0; i < data.size(); i++) {
            Specialty specialty = new Specialty(Integer.parseInt(data.get(i)[data.get(i).length - 1]));
            data.get(i)[data.get(i).length - 1] = specialty.getName();
        }
        String[] columnNames = {"ID", "Username", "Name", "Phone", "Email", "Address", "DOB", "Specialty"};

        JTable table = new JTable(data.toArray(new String[0][]), columnNames);
        table.setRowHeight(30);
        table.setForeground(Color.WHITE);
        table.setBackground(Color.BLACK);
        table.setFont(new Font("Helvetica", Font.PLAIN, 20));

        DefaultTableModel model = new DefaultTableModel(data.toArray(new String[0][]), columnNames) {
            boolean[] canEdit = new boolean[]{false, false, false, false, false, false, false};

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit[columnIndex];
            }
        };
        table.setModel(model);

        TableColumnModel tableColumnModel = table.getColumnModel();
        tableColumnModel.getColumn(0).setPreferredWidth(50);
        tableColumnModel.getColumn(1).setPreferredWidth(125);
        tableColumnModel.getColumn(2).setPreferredWidth(175);

        for (int i = 3; i < tableColumnModel.getColumnCount(); i++) {
            tableColumnModel.getColumn(i).setPreferredWidth(150);
        }

        JTableHeader tableHeader = table.getTableHeader();
        tableHeader.setFont(new Font("Helvetica", Font.BOLD, 20));
        tableHeader.setForeground(new Color(29, 182, 242));
        tableHeader.setBackground(Color.BLACK);

        JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.setPreferredSize(new Dimension(1100, 700));
        scrollPane.setBackground(Color.BLACK);

        panel.add(scrollPane);
        return panel;
    }

    public JPanel viewPatients() {
        JPanel panel = new JPanel();
        panel.setBackground(Color.BLACK);
        panel.setLayout(new GridBagLayout());

        ArrayList<String[]> data = new ArrayList<>();
        try {
            resultSet = statement.executeQuery("select * from Patient");

            while (resultSet.next()) {
                String[] row = {String.valueOf(resultSet.getInt(1)),
                        resultSet.getString(9).trim(),
                        resultSet.getString(2).trim() + " " + resultSet.getString(3).trim() + " " + resultSet.getString(4).trim(),
                        resultSet.getString(5).trim(), resultSet.getString(6).trim(), resultSet.getString(7).trim(),
                        resultSet.getString(8).trim()
                };
                data.add(row);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

        String[] columnNames = {"ID", "Username", "Name", "Phone", "Email", "Address", "DOB"};;

        JTable table = new JTable(data.toArray(new String[0][]), columnNames);
        table.setRowHeight(30);
        table.setForeground(Color.WHITE);
        table.setBackground(Color.BLACK);
        table.setFont(new Font("Helvetica", Font.PLAIN, 20));

        DefaultTableModel model = new DefaultTableModel(data.toArray(new String[0][]), columnNames) {
            boolean[] canEdit = new boolean[]{false, false, false, false, false, false};

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit[columnIndex];
            }
        };
        table.setModel(model);

        TableColumnModel tableColumnModel = table.getColumnModel();
        tableColumnModel.getColumn(0).setPreferredWidth(50);
        tableColumnModel.getColumn(1).setPreferredWidth(125);
        tableColumnModel.getColumn(2).setPreferredWidth(175);

        for (int i = 3; i < tableColumnModel.getColumnCount(); i++) {
            tableColumnModel.getColumn(i).setPreferredWidth(150);
        }

        JTableHeader tableHeader = table.getTableHeader();
        tableHeader.setFont(new Font("Helvetica", Font.BOLD, 20));
        tableHeader.setForeground(new Color(29, 182, 242));
        tableHeader.setBackground(Color.BLACK);

        JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.setPreferredSize(new Dimension(1100, 700));
        scrollPane.setBackground(Color.BLACK);

        panel.add(scrollPane);
        return panel;
    }

    public JPanel viewDiseases() {
        JPanel panel = new JPanel();
        panel.setBackground(Color.BLACK);
        panel.setLayout(new GridBagLayout());

        ArrayList<String[]> data = new ArrayList<>();
        try {
            resultSet = statement.executeQuery("select * from Disease");

            while (resultSet.next()) {
                String[] row = {String.valueOf(resultSet.getInt(1)), "", ""};
                data.add(row);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        for (int i = 0; i < data.size(); i++) {
            Disease disease = new Disease(Integer.parseInt(data.get(i)[0]));
            data.get(i)[0] += " " + disease.getName();

            ArrayList<Integer> symptomIds = new ArrayList<>();
            try {
                resultSet = statement.executeQuery("select * from SymptomClassification");
                while (resultSet.next()) {
                    if (resultSet.getInt(2) == disease.getId()) {
                        symptomIds.add(resultSet.getInt(1));
                    }
                }
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }

            ArrayList<Symptom> symptoms = new ArrayList<>();
            for (int j = 0; j < symptomIds.size(); j++) {
                Symptom symptom = new Symptom(symptomIds.get(j));
                symptoms.add(symptom);
                data.get(i)[1] += symptom.getId() + ": " + symptom.getName() + " ";
            }

            Specialty specialty = new Specialty(disease.getClassId("Disease"));
            data.get(i)[2] = specialty.getId() + ": " + specialty.getName();
        }
        String[] columnNames = {"Disease", "Symptom", "Specialty"};

        JTable table = new JTable(data.toArray(new String[0][]), columnNames);
        table.setRowHeight(30);
        table.setForeground(Color.WHITE);
        table.setBackground(Color.BLACK);
        table.setFont(new Font("Helvetica", Font.PLAIN, 20));

        DefaultTableModel model = new DefaultTableModel(data.toArray(new String[0][]), columnNames) {
            boolean[] canEdit = new boolean[]{false, false, false};

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit[columnIndex];
            }
        };
        table.setModel(model);

        TableColumnModel tableColumnModel = table.getColumnModel();
        tableColumnModel.getColumn(0).setPreferredWidth(200);
        tableColumnModel.getColumn(1).setPreferredWidth(700);
        tableColumnModel.getColumn(2).setPreferredWidth(200);

        JTableHeader tableHeader = table.getTableHeader();
        tableHeader.setFont(new Font("Helvetica", Font.BOLD, 20));
        tableHeader.setForeground(new Color(29, 182, 242));
        tableHeader.setBackground(Color.BLACK);

        JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.setPreferredSize(new Dimension(1100, 700));
        scrollPane.setBackground(Color.BLACK);

        panel.add(scrollPane);
        return panel;
    }

    public JPanel viewFeedback() {
        JPanel panel = new JPanel();
        panel.setBackground(Color.BLACK);
        panel.setLayout(new GridBagLayout());

        ArrayList<String[]> data = new ArrayList<>();
        try {
            resultSet = statement.executeQuery("select * from Feedback");

            while (resultSet.next()) {
                String[] row = {String.valueOf(resultSet.getInt(1)), String.valueOf(resultSet.getInt(2)), resultSet.getString(3).trim(), resultSet.getString(4).trim()};
                data.add(row);
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
        for (int i = 0; i < data.size(); i++) {
            Patient patient = new Patient(Integer.parseInt(data.get(i)[0]));
            Doctor doctor = new Doctor(Integer.parseInt(data.get(i)[1]));
            data.get(i)[0] += " " + patient.getUsername();
            data.get(i)[1] += " " + doctor.getUsername();
        }
        String[] columnNames = {"Patient", "Doctor", "Feedback", "Date"};

        JTable table = new JTable(data.toArray(new String[0][]), columnNames);
        table.setRowHeight(30);
        table.setForeground(Color.WHITE);
        table.setBackground(Color.BLACK);
        table.setFont(new Font("Helvetica", Font.PLAIN, 20));

        DefaultTableModel model = new DefaultTableModel(data.toArray(new String[0][]), columnNames) {
            boolean[] canEdit = new boolean[]{false, false, false, false};

            @Override
            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit[columnIndex];
            }
        };
        table.setModel(model);

        TableColumnModel tableColumnModel = table.getColumnModel();
        tableColumnModel.getColumn(0).setPreferredWidth(100);
        tableColumnModel.getColumn(1).setPreferredWidth(100);
        tableColumnModel.getColumn(2).setPreferredWidth(200);
        tableColumnModel.getColumn(3).setPreferredWidth(100);

        JTableHeader tableHeader = table.getTableHeader();
        tableHeader.setFont(new Font("Helvetica", Font.BOLD, 20));
        tableHeader.setForeground(new Color(29, 182, 242));
        tableHeader.setBackground(Color.BLACK);

        JScrollPane scrollPane = new JScrollPane(table);
        scrollPane.setPreferredSize(new Dimension(1100, 700));
        scrollPane.setBackground(Color.BLACK);

        panel.add(scrollPane);

        return panel;
    }
}
