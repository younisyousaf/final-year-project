import { DEFAULT_MAP_CENTER } from "../../../../constants";
import { Map } from "./Map";
import { MapPin } from "./MapPin";

export default {
  Default: () => {
    return <Map center={DEFAULT_MAP_CENTER} />;
  },
  WithPin: () => {
    return (
      <Map center={DEFAULT_MAP_CENTER}>
        <MapPin latitude={30.375321} longitude={69.345116} />
      </Map>
    );
  }
};
