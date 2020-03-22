package org.transitclock.api.data;

import java.util.Date;
import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlRootElement;

import org.transitclock.db.structs.Location;
import org.transitclock.ipc.data.IpcDiversion;
@XmlRootElement(name = "diversion")
public class ApiDiversion {
	@XmlAttribute
	private String routeId;
	@XmlAttribute
	private String tripId;
	@XmlAttribute
	private String shapeId;
	@XmlAttribute
	private int startStopSeq;
	@XmlAttribute
	private int distanceStartAlongSegment;
	@XmlAttribute
	private int returnStopSeq;
	@XmlAttribute
	private int distanceEndAlongSegment;
	@XmlAttribute
	private List<Location> detourPath;
	@XmlAttribute
	private List<Location> stopLocations;
	@XmlAttribute
	private Date startTime;
	@XmlAttribute
	private Date  endTime;
	
	/**
	 * Need a no-arg constructor for Jersey. Otherwise get really obtuse
	 * "MessageBodyWriter not found for media type=application/json" exception.
	 */
	public ApiDiversion() {
		
	}

	public ApiDiversion(IpcDiversion diversion)
	{
		this.startStopSeq=diversion.getStartStopSeq();
		this.returnStopSeq=diversion.getReturnStopSeq();
		this.routeId=diversion.getRouteId();
		this.shapeId=diversion.getShapeId();
		this.tripId=diversion.getTripId();	
		this.distanceStartAlongSegment=diversion.getDistanceStartAlongSegment();
		this.distanceStartAlongSegment=diversion.getDistanceStartAlongSegment();	
		this.detourPath=diversion.getDetourPath();
		this.stopLocations=diversion.getStopLocations();
		this.startTime=diversion.getStartTime();
		this.endTime=diversion.getEndTime();		
	}

	public String getRouteId() {
		return routeId;
	}

	public void setRouteId(String routeId) {
		this.routeId = routeId;
	}

	public String getTripId() {
		return tripId;
	}

	public void setTripId(String tripId) {
		this.tripId = tripId;
	}

	public String getShapeId() {
		return shapeId;
	}

	public void setShapeId(String shapeId) {
		this.shapeId = shapeId;
	}

	public int getStartStopSeq() {
		return startStopSeq;
	}

	public void setStartStopSeq(int startStopSeq) {
		this.startStopSeq = startStopSeq;
	}

	public int getDistanceStartAlongSegment() {
		return distanceStartAlongSegment;
	}

	public void setDistanceStartAlongSegment(int distanceStartAlongSegment) {
		this.distanceStartAlongSegment = distanceStartAlongSegment;
	}

	public int getReturnStopSeq() {
		return returnStopSeq;
	}

	public void setReturnStopSeq(int returnStopSeq) {
		this.returnStopSeq = returnStopSeq;
	}

	public int getDistanceEndAlongSegment() {
		return distanceEndAlongSegment;
	}

	public void setDistanceEndAlongSegment(int distanceEndAlongSegment) {
		this.distanceEndAlongSegment = distanceEndAlongSegment;
	}

	public List<Location> getDetourPath() {
		return detourPath;
	}

	public void setDetourPath(List<Location> detourPath) {
		this.detourPath = detourPath;
	}

	public List<Location> getStopLocations() {
		return stopLocations;
	}

	public void setStopLocations(List<Location> stopLocations) {
		this.stopLocations = stopLocations;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
}