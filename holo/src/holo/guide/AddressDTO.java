package holo.guide;

public class AddressDTO {

	public String id;			//아이디
	public String lat;			//주소 중심좌표
	public String lng;			//주소 경도
	public String address;		//행정주소
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	


}
