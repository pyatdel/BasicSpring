package kr.or.ddit.websocket;

public class AddressDto {
    private String empId;
    private String empName;
    private String empProfile;

    // Getters and Setters
    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getEmpProfile() {
        return empProfile;
    }

    public void setEmpProfile(String empProfile) {
        this.empProfile = empProfile;
    }
}