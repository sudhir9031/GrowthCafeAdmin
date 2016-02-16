package com.slms.webapp.form;

public class ReviewVo {
	private String organisationName;
	private String param;
	private String valueLabel;
	private int valueId;
	private int paramId;
	
	/**
	 * @return the organisationName
	 */
	public String getOrganisationName() {
		return organisationName;
	}
	/**
	 * @param organisationName the organisationName to set
	 */
	public void setOrganisationName(String organisationName) {
		this.organisationName = organisationName;
	}
	/**
	 * @return the param
	 */
	public String getParam() {
		return param;
	}
	/**
	 * @param param the param to set
	 */
	public void setParam(String param) {
		this.param = param;
	}
	/**
	 * @return the valueLabel
	 */
	public String getValueLabel() {
		return valueLabel;
	}
	/**
	 * @param valueLabel the valueLabel to set
	 */
	public void setValueLabel(String valueLabel) {
		this.valueLabel = valueLabel;
	}
	public int getValueId() {
		return valueId;
	}
	public void setValueId(int valueId) {
		this.valueId = valueId;
	}
	public int getParamId() {
		return paramId;
	}
	public void setParamId(int paramId) {
		this.paramId = paramId;
	}
	
	
}
