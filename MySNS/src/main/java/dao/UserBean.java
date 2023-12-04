// UserBean.java
package dao;

import java.sql.Timestamp;

public class UserBean {
    private String id; // 아이디를 저장할 필드
    private String ps; // 비밀번호를 저장할 필드
    private String name; //이름을 저장할 필드
    private Timestamp ts; // 타임스탬프를 저장할 필드
    private String phone; // 전화번호를 저장할 필드
    private String email; // 이메일을 저장할 필드

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPs() {
        return ps;
    }

    public void setPs(String ps) {
        this.ps = ps;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Timestamp getTs() {
        return ts;
    }

    public void setTs(Timestamp ts) {
        this.ts = ts;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
