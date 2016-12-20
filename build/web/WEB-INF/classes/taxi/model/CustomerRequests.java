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
@Table(name = "customer_requests")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "CustomerRequests.findAll", query = "SELECT c FROM CustomerRequests c"),
    @NamedQuery(name = "CustomerRequests.findByRequestId", query = "SELECT c FROM CustomerRequests c WHERE c.requestId = :requestId"),
    @NamedQuery(name = "CustomerRequests.findByPresentZipcode", query = "SELECT c FROM CustomerRequests c WHERE c.presentZipcode = :presentZipcode"),
    @NamedQuery(name = "CustomerRequests.findByDestinationAddressline", query = "SELECT c FROM CustomerRequests c WHERE c.destinationAddressline = :destinationAddressline"),
    @NamedQuery(name = "CustomerRequests.findBySelectedDriverId", query = "SELECT c FROM CustomerRequests c WHERE c.selectedDriverId = :selectedDriverId"),
    @NamedQuery(name = "CustomerRequests.findByDestinationZipcode", query = "SELECT c FROM CustomerRequests c WHERE c.destinationZipcode = :destinationZipcode"),
    @NamedQuery(name = "CustomerRequests.findBySearchdriverRating", query = "SELECT c FROM CustomerRequests c WHERE c.searchdriverRating = :searchdriverRating"),
    @NamedQuery(name = "CustomerRequests.findBySearchDatetime", query = "SELECT c FROM CustomerRequests c WHERE c.searchDatetime = :searchDatetime"),
    @NamedQuery(name = "CustomerRequests.findBySourceAddressline", query = "SELECT c FROM CustomerRequests c WHERE c.sourceAddressline = :sourceAddressline")})
public class CustomerRequests implements Serializable {
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "distance")
    private BigDecimal distance;
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "request_id")
    private Integer requestId;
    @Column(name = "present_zipcode")
    private Integer presentZipcode;
    @Column(name = "destination_addressline")
    private String destinationAddressline;
    @Column(name = "selected_driver_id")
    private Integer selectedDriverId;
    @Column(name = "destination_zipcode")
    private Integer destinationZipcode;
    @Column(name = "search_driverRating")
    private Integer searchdriverRating;
    @Column(name = "search_datetime")
    @Temporal(TemporalType.TIMESTAMP)
    private Date searchDatetime;
    @Column(name = "source_addressline")
    private String sourceAddressline;
    @Column(name = "customer_id")
    private int customerId;

    public CustomerRequests() {
    }

    public CustomerRequests(Integer requestId) {
        this.requestId = requestId;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    public Integer getPresentZipcode() {
        return presentZipcode;
    }

    public void setPresentZipcode(Integer presentZipcode) {
        this.presentZipcode = presentZipcode;
    }

    public String getDestinationAddressline() {
        return destinationAddressline;
    }

    public void setDestinationAddressline(String destinationAddressline) {
        this.destinationAddressline = destinationAddressline;
    }

    public Integer getSelectedDriverId() {
        return selectedDriverId;
    }

    public void setSelectedDriverId(Integer selectedDriverId) {
        this.selectedDriverId = selectedDriverId;
    }

    public Integer getDestinationZipcode() {
        return destinationZipcode;
    }

    public void setDestinationZipcode(Integer destinationZipcode) {
        this.destinationZipcode = destinationZipcode;
    }

    public Integer getSearchdriverRating() {
        return searchdriverRating;
    }

    public void setSearchdriverRating(Integer searchdriverRating) {
        this.searchdriverRating = searchdriverRating;
    }

    public Date getSearchDatetime() {
        return searchDatetime;
    }

    public void setSearchDatetime(Date searchDatetime) {
        this.searchDatetime = searchDatetime;
    }

    public String getSourceAddressline() {
        return sourceAddressline;
    }

    public void setSourceAddressline(String sourceAddressline) {
        this.sourceAddressline = sourceAddressline;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (requestId != null ? requestId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CustomerRequests)) {
            return false;
        }
        CustomerRequests other = (CustomerRequests) object;
        if ((this.requestId == null && other.requestId != null) || (this.requestId != null && !this.requestId.equals(other.requestId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "taxi.model.CustomerRequests[ requestId=" + requestId + " ]";
    }

    public BigDecimal getDistance() {
        return distance;
    }

    public void setDistance(BigDecimal distance) {
        this.distance = distance;
    }
    
}
