package org.transitclock.api.rootResources;

import javax.ws.rs.BeanParam;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.transitclock.api.data.ApiCacheDetails;
import org.transitclock.api.data.ApiDiversion;
import org.transitclock.api.data.ApiDiversions;
import org.transitclock.api.utils.StandardParameters;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;

@Path("/key/{key}/agency/{agency}")
public class DiversionApi {
	@Path("/command/getDiversionsByRoute")
	@GET
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	@Operation(summary="Get list of active diversions for a route.",
	description="This is to give the means of manually setting a vehicle unpredictable and unassigned so it will be reassigned quickly.",
	tags= {"command","vehicle"})
	public Response getDiversionsByRouteId(@BeanParam StandardParameters stdParameters,
			@Parameter(description="routeId to get diversions for.",required=true) @PathParam("routeId") String routeId)
	{
		stdParameters.validate();
		
		return stdParameters.createResponse(new ApiDiversions());
	}
	@Path("/command/getDiversionsByTrip")
	@GET
	@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	@Operation(summary="Get a list of active diversions for a trip",
	description="This is to give the means of manually setting a vehicle unpredictable and unassigned so it will be reassigned quickly.",
	tags= {"command","vehicle"})
	public Response getDiversionsByTripId(@BeanParam StandardParameters stdParameters,
			@Parameter(description="tripId to get diversions for.",required=true) @PathParam("tripId") String tripId)
	{
		stdParameters.validate();
	
		
		return stdParameters.createResponse(new ApiDiversions());
	}
}
