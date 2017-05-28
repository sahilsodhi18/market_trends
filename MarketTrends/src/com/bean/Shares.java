package com.bean;

public class Shares 
{
	private String custemail;
	private String csymbol;
	private String srate;
	private String noofshares;
	private String tvalue;
	private String lrate;
	private String rrate;

	
	public String getLrate() {
		return lrate;
	}
	public void setLrate(String lrate) {
		this.lrate = lrate;
	}
	public String getRrate() {
		return rrate;
	}
	public void setRrate(String rrate) {
		this.rrate = rrate;
	}
	private String tdate;
	private String status;
	public String getCustemail() {
		return custemail;
	}
	public void setCustemail(String custemail) {
		this.custemail = custemail;
	}
	public String getCsymbol() {
		return csymbol;
	}
	public void setCsymbol(String csymbol) {
		this.csymbol = csymbol;
	}
	public String getSrate() {
		return srate;
	}
	public void setSrate(String srate) {
		this.srate = srate;
	}
	public String getNoofshares() {
		return noofshares;
	}
	public void setNoofshares(String noofshares) {
		this.noofshares = noofshares;
	}
	public String getTvalue() {
		return tvalue;
	}
	public void setTvalue(String tvalue) {
		this.tvalue = tvalue;
	}
	public String getTdate() {
		return tdate;
	}
	public void setTdate(String tdate) {
		this.tdate = tdate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}

}
