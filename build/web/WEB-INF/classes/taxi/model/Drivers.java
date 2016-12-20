/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package taxi.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author vav
 */
@Entity
@Table(name = "DRIVERS")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Drivers.findAll", query = "SELECT d FROM Drivers d"),
    @NamedQuery(name = "Drivers.findByDriverid", query = "SELECT d FROM Drivers d WHERE d.driverid = :driverid"),
    @NamedQuery(name = "Drivers.findByInsuranceComp", query = "SELECT d FROM Drivers d WHERE d.insuranceComp = :insuranceComp"),
    @NamedQuery(name = "Drivers.findByAge", query = "SELECT d FROM Drivers d WHERE d.age = :age"),
    @NamedQuery(name = "Drivers.findByDate", query = "SELECT d FROM Drivers d WHERE d.date = :date"),
    @NamedQuery(name = "Drivers.findByInsuranceNum", query = "SELECT d FROM Drivers d WHERE d.insuranceNum = :insuranceNum"),
    @NamedQuery(name = "Drivers.findByLicenseNum", query = "SELECT d FROM Drivers d WHERE d.licenseNum = :licenseNum"),
    @NamedQuery(name = "Drivers.findByVehCapacity", query = "SELECT d FROM Drivers d WHERE d.vehCapacity = :vehCapacity"),
    @NamedQuery(name = "Drivers.findByVehColor", query = "SELECT d FROM Drivers d WHERE d.vehColor = :vehColor"),
    @NamedQuery(name = "Drivers.findByVehName", query = "SELECT d FROM Drivers d WHERE d.vehName = :vehName"),
    @NamedQuery(name = "Drivers.findByVehicleReg", query = "SELECT d FROM Drivers d WHERE d.vehicleReg = :vehicleReg"),
    @NamedQuery(name = "Drivers.findByCurrentRatemile", query = "SELECT d FROM Drivers d WHERE d.currentRatemile = :currentRatemile")})
public class Drivers implements Serializable {
    @Column(name = "AVAIL_STATUS")
    private String availStatus;
    @Column(name = "MAX_MILES_TO_DEST")
    private Integer maxMilesToDest;
    @Column(name = "AVG_RATING")
    private Integer avgRating;
   
    private static final long serialVersionUID = 1L;
    @Id
     @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "DRIVERID")
    private Integer driverid;
    @Column(name = "INSURANCE_COMP")
    private String insuranceComp;
    @Column(name = "AGE")
    private Integer age;
    @Column(name = "date")
    @Temporal(TemporalType.DATE)
    private Date date;
    @Column(name = "INSURANCE_NUM")
    private String insuranceNum;
    @Column(name = "LICENSE_NUM")
    private String licenseNum;
    @Column(name = "VEH_CAPACITY")
    private Integer vehCapacity;
     @Column(name = "Zipcode")
    private int zipcode;
    @Column(name = "VEH_COLOR")
    private String vehColor;
    @Column(name = "VEH_NAME")
    private String vehName;
    @Column(name = "VEHICLE_REG")
    private String vehicleReg;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "currentRate_mile")
    private BigDecimal currentRatemile;
   
    private int userid;

    public Drivers() {
    }

    public Drivers(Integer driverid) {
        this.driverid = driverid;
    }

    public Integer getDriverid() {
        return driverid;
    }

    public void setDriverid(Integer driverid) {
        this.driverid = driverid;
    }

    public String getInsuranceComp() {
        return insuranceComp;
    }

    public void setInsuranceComp(String insuranceComp) {
        this.insuranceComp = insuranceComp;
    }
        public int getZipcode() {
        return zipcode;
    }

    public void setZipCode(int zipcode) {
        this.zipcode = zipcode;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getInsuranceNum() {
        return insuranceNum;
    }

    public void setInsuranceNum(String insuranceNum) {
        this.insuranceNum = insuranceNum;
    }

    public String getLicenseNum() {
        return licenseNum;
    }

    public void setLicenseNum(String licenseNum) {
        this.licenseNum = licenseNum;
    }

    public Integer getVehCapacity() {
        return vehCapacity;
    }

    public void setVehCapacity(Integer vehCapacity) {
        this.vehCapacity = vehCapacity;
    }

    public String getVehColor() {
        return vehColor;
    }

    public void setVehColor(String vehColor) {
        this.vehColor = vehColor;
    }

    public String getVehName() {
        return vehName;
    }

    public void setVehName(String vehName) {
        this.vehName = vehName;
    }

    public String getVehicleReg() {
        return vehicleReg;
    }

    public void setVehicleReg(String vehicleReg) {
        this.vehicleReg = vehicleReg;
    }

    public BigDecimal getCurrentRatemile() {
        return currentRatemile;
    }

    public void setCurrentRatemile(BigDecimal currentRatemile) {
        this.currentRatemile = currentRatemile;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (driverid != null ? driverid.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Drivers)) {
            return false;
        }
        Drivers other = (Drivers) object;
        if ((this.driverid == null && other.driverid != null) || (this.driverid != null && !this.driverid.equals(other.driverid))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "taxi.model.Drivers[ driverid=" + driverid + " ]";
    }

    public String getAvailStatus() {
        return availStatus;
    }

    public void setAvailStatus(String availStatus) {
        this.availStatus = availStatus;
    }

    public Integer getMaxMilesToDest() {
        return maxMilesToDest;
    }

    public void setMaxMilesToDest(Integer maxMilesToDest) {
        this.maxMilesToDest = maxMilesToDest;
    }

    public Integer getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(Integer avgRating) {
        this.avgRating = avgRating;
    }
   
}
