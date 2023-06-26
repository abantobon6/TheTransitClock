package org.transitclock.core.barefoot;

import java.util.Date;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.transitclock.core.MapMatcher;
import org.transitclock.db.structs.AvlReport;
import org.transitclock.db.structs.Block;
import org.transitclock.db.structs.Location;

import com.bmwcarit.barefoot.matcher.Matcher;
import com.bmwcarit.barefoot.matcher.MatcherCandidate;
import com.bmwcarit.barefoot.matcher.MatcherKState;
import com.bmwcarit.barefoot.matcher.MatcherSample;
import com.bmwcarit.barefoot.roadmap.Road;
import com.bmwcarit.barefoot.roadmap.RoadMap;
import com.bmwcarit.barefoot.roadmap.RoadPoint;
import com.bmwcarit.barefoot.roadmap.TimePriority;
import com.bmwcarit.barefoot.spatial.Geography;
import com.bmwcarit.barefoot.topology.Dijkstra;
import com.esri.core.geometry.Point;
import org.transitclock.utils.Geo;

public class BareFootMapMatcher implements MapMatcher {

	private RoadMap barefootMap = null;

	private Matcher barefootMatcher = null;

	private MatcherKState barefootState = null;

	private static final Logger logger = LoggerFactory.getLogger(BareFootMapMatcher.class);

	@Override
	public void setMatcher(Block block, Date assignmentTime) {

		if (block != null) {

			int tripIndex = block.activeTripIndex(assignmentTime, 0);

			TransitClockRoadReader roadReader = new TransitClockRoadReader(block, tripIndex);

			barefootMap = RoadMap.Load(roadReader);

			barefootMap.construct();

			barefootMatcher = new Matcher(barefootMap, new Dijkstra<Road, RoadPoint>(), new TimePriority(),
					new Geography());

			barefootState = new MatcherKState();
		}
	}

	@Override
	public Location getEstimateLocation(AvlReport avlReport) {

		if (barefootState != null) {
			Point point = new Point();
			point.setX(avlReport.getLon());
			point.setY(avlReport.getLat());
			MatcherSample sample = new MatcherSample(avlReport.getTime(), point);

			Set<MatcherCandidate> result = barefootMatcher.execute(barefootState.vector(), barefootState.sample(),
					sample);

			barefootState.update(result, sample);

			MatcherCandidate estimate = barefootState.estimate();

			if (estimate != null) {
				
				estimate.point().edge().base().id(); // road id
				estimate.point().edge().heading(); // heading
				estimate.point().geometry(); // GPS position (on the road)
				if (estimate.transition() != null)
					estimate.transition().route().geometry(); // path geometry from last matching
																// candidate
				Location location = new Location(estimate.point().geometry().getY(),
						estimate.point().geometry().getX());

				if (!location.equals(avlReport.getLocation())) {
					
					logger.debug("Vehicle {} assigned to {} is {} metres from GPS coordindates.", avlReport.getVehicleId(),avlReport.getAssignmentId(),Geo.distance(location, avlReport.getLocation()));
				}
				return location;
			}

		}
		return null;
	}

}
