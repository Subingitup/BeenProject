<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>병원검색</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=25731966bd6475ae2f7635d90222da92&libraries=services,clusterer,drawing"></script>
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'
	rel='stylesheet'>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewList.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/map.css">

</head>

<body>
	<%@ include file="../../petmedic_navbar.jsp"%>
	<div class="container" style="margin-top: 100px;">
		<div class="map_wrap ">
			<div id="map2" class="blurblur"
				style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>
			<div id="menu_wrap" class="bg_white">

				<div id="search-container">
					<button type="button" class="search-button sbtn" onclick="geoLoc()">
						<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAVVJREFUSEvFldsxBUEQhr8TgEsIRIAMiAABKLzyQCg88Io6CRABGSACQnAJgPpUj5paM7tnSw39cnbPTPf/9+XvndDYJo3jMxbgIwjN7DfzxQjcBGAV2AXWAZ+1B+AOuIrnaqX7MlgELoCtgT5dA/vAS+leDcDgT4C/mkxPMrZmchyZeW7w5RJIDUBWm8BrlMaSlEwgS7UA6LPdvVQC0Ok+Lq4N1Tj6Ur1fArAUR8BplCGROgN24mUKHGZsL6NcXZ+iDizHCpCzN/hBJ/3zDCRlra9+35ZnkGY8HeZnb8BcB+AdmM/+K/r/KUAi85sSPWZi/Ir3L01uPqZmloSmQjd6tCCZ21D8TWmt9K2K51CogM65M54UbWC1sheNU/FLY1aFfu4hA7sy+kzmAo1adnlA2RrAda0ANafFHSSB2p6qTlEf2yYfnBywOcBAO34ej/0mjwb4BBbRUBnf8oRkAAAAAElFTkSuQmCC" />
					</button>
					<input class="searchbox" type="text" id="search-input"
						placeholder="ex) 안양동물병원, 안양시">
					<button id="search-button" class="search-button sbtn"
						onclick="mapStart()">
						<img
							src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAVFJREFUSEvVleExBEEQRt9FQAoiQATIgAgQASJABIgAESACZEAEyIAIqKd6qub2Zmen7N4P/eu2dqdf99dfz81YcsyWnJ8+wCpwBOwCG1HEC3APXAGfrYWVAAfABSCkFCY/AW5aIF2Aya/j4ANwCTzF8zZwBmzF8150VOXkACt+i8oPKxUKOQ2Z1obkygHpoJWrfS3syk7Oo6veb3OAQ1wHdjJZ+g4q1yPgmc1aJTngOz5stW7T92MBXxW3/db7V4mc0R3wDChX0wzSkF0mLdgyZPdBKzcBtOk7sBLO0CGlSIV8xJZXt7o70NS6ibWiyZTBUAr9nyQZtGh3Bqlat9m27aQUDtb3wrSpv2/7NKpddsexcO6G8RpXgwmVJe2N77yX3P6FaPV86Wx+b/VCxgBS0v2MvtDJWMAgZApAFzJ3E08FSBCtPfdHNCWg6NT/D/gBeOVFGZeTouUAAAAASUVORK5CYII=" />
					</button>
				</div>
				<c:set var="sti" value="0" />
				<ul id="placesList">
				</ul>
			</div>

		</div>
	</div>
	<br>
	<br>
	<br>

	<%@ include file="../../footer.jsp"%>
	<script>
		var hospitalList = [];

		//내위치
		function geoLoc() {
			console.log("geoLoc 실행")
			// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
			if (navigator.geolocation) {

				// GeoLocation을 이용해서 접속 위치를 얻어옵니다
				navigator.geolocation.getCurrentPosition(function(position) {

					var lat = position.coords.latitude, // 위도
					lon = position.coords.longitude; // 경도

					var locPosition = new kakao.maps.LatLng(lat, lon) // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다

					// 마커 표시합니다
					displayMarker(locPosition);

				});

			} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

				var locPosition = new kakao.maps.LatLng(33.450701, 126.570667)

				displayMarker(locPosition);
			}

		}

		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition) {

			var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png', // 마커이미지의 주소입니다    
			// 		    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
			imageSize = new kakao.maps.Size(35, 45), // 마커이미지의 크기입니다
			imageOption = {
				offset : new kakao.maps.Point(27, 45)
			}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

			// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
					imageOption);

			// 마커를 생성합니다
			var marker_me = new kakao.maps.Marker({
				map : map,
				position : locPosition,
				image : markerImage
			// 마커이미지 설정 
			});

			// 지도 중심좌표를 접속위치로 변경합니다
			map.setCenter(locPosition);
		}

		//병원검색 시작
		function mapStart() {
			var keyword = document.getElementById('search-input').value;
			// Find all the elements with the class name 'icon'
			var icons = document.querySelectorAll('.icon');
			var tooltips = document.querySelectorAll('.tooltip');
			var balloons = document.querySelectorAll('.balloon');

			// Iterate over each element and remove it
			icons.forEach(function(icon) {
			  icon.remove();
			});
			tooltips.forEach(function(tooltip) {
			  tooltip.remove();
			});
			balloons.forEach(function(balloon) {
				balloon.remove();
			});
			
			getHospitalList(keyword);
		
		}

		//DB에 키워드로 데이터 요청
		function getHospitalList(keyword) {
			$.ajax({
				url : '/getHosList',
				type : 'post',
				dataType : 'json',
				data : {
					keyword : keyword
				}, // Pass the keyword as data to the server
				async : false,
				success : function(result) {
					hospitalList = result;

					if (hospitalList.length == 0) {
						alert("해당되는 병원이 없습니다. 다시 검색해주세요")
					}

					console.log("hospitalList: " + hospitalList);
					// Call the function to add markers
					createMap();
				},
				error : function(xhr, status, error) {
					console.log('Error:', error);
				}
			});
		}

		//initalizing a map
		var mapContainer = document.getElementById('map2');
		var mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667),
			level : 3
		};
		var map = new kakao.maps.Map(mapContainer, mapOption);

		//맵생성
		function createMap(map) {
			var mapContainer = document.getElementById('map2');
			var mapOption = {
				center : new kakao.maps.LatLng(33.450701, 126.570667),
				level : 3
			};
			var map = new kakao.maps.Map(mapContainer, mapOption);

			mapResults(map);
		}

		//DB데이터 필터링
		function mapResults(map) {

			console.log(map);

			// Clear the contents of the placesList
			var placesList = document.getElementById('placesList');
			placesList.innerHTML = '';

			var filteredHospitals = [];

			for (var i = 0; i < hospitalList.length; i++) {
				console.log('1');
				filteredHospitals.push(hospitalList[i]);

			}

			if (hospitalList.length == 0) {
				for (var i = 0; i < hospitalList.length; i++) {
					var hospital = hospitalList[i];
					var number = i;
					console.log('2');
					geocodeAddress(number, hospital, map);
				}
			} else {
				for (var i = 0; i < filteredHospitals.length; i++) {
					var hospital = filteredHospitals[i];
					var number = i;
					console.log('3');
					geocodeAddress(number, hospital, map);
				}
			}

		}

		//주소를 좌표로 변환, 커스텀오버레이 생성,지도에 도출
		function geocodeAddress(number, hospital, map) {
			var hospitalInfo = hospital
			var name = hospitalInfo.hos_name
			var address = hospitalInfo.hos_addr2
			var address_jibun = hospitalInfo.hos_addr3
			var hos_star = hospitalInfo.hos_star
			var hos_cate = hospitalInfo.hos_cate
			var hos_hol = hospitalInfo.hos_hol
			if (hos_hol == null) {
				hos_hol = "없음"
			}
			var hos_price = hospitalInfo.hos_price
			var hos_start = hospitalInfo.hos_start
			var hos_end = hospitalInfo.hos_end
			var hos_s_lunch = hospitalInfo.hos_s_lunch
			var hos_e_lunch = hospitalInfo.hos_e_lunch
			var hos_tel = hospitalInfo.hos_tel

			var geocoder = new kakao.maps.services.Geocoder();

			geocoder
					.addressSearch(
							address,
							function(result, status) {
								if (status === kakao.maps.services.Status.OK) {

									var coords = new kakao.maps.LatLng(
											result[0].y, result[0].x);
									var marker = new kakao.maps.Marker({
										map : map,
										position : coords
									});

									var customOverlay = new kakao.maps.CustomOverlay(
											{
												map : map,
												clickable : true,
												content : '<div class="search-button-map" onclick="location.href=\'getHos?hos_addr2='
														+ address
														+ '&hos_addr3='
														+ address_jibun
														+ '&hos_name='
														+ name
														+ '\'">'
														+ name
														+ '</div>',
												position : coords,
												xAnchor : 0.5,
												yAnchor : 2.0,
												zIndex : 1
											});

									// 툴팁을 노출하는 마커를 생성합니다.
									var marker1 = new TooltipMarker(coords,
											name);
									marker1.setMap(map);

									// MarkerTracker를 생성합니다.
									var markerTracker1 = new MarkerTracker(map,
											marker1, name);

									// marker의 추적을 시작합니다.
									markerTracker1.run();

									// 커스텀 오버레이를 지도에 표시합니다
									customOverlay.setMap(map);

									// Append the result to the placesList
									var li = document.createElement('li');

									var itemStr = '<span class="markerbg"></span>'
											+ '<div class="revShadow review-box" >'
											+ '<div class="search-button-map" onclick="location.href=\'getHos?hos_addr2='
											+ address
											+ '&hos_addr3='
											+ address_jibun
											+ '&hos_name='
											+ name
											+ '\'">'
											+ '<strong>'
											+ name
											+ '</strong>' + '</div>';

									if (address) {
										itemStr += '<div onclick="moveToMarker(this)">'
												+ '<div class="addr_2_map">'
												+ address + '</div>';
									} else {
										itemStr += '<div class="jibun gray">'
												+ address_jibun + '</div>';
									}

									itemStr += '<div style="display: inline;" class="star-rating" id="st-' + number + '">'
											+ '</div>' + '<span>'
											+ hos_star
											+ '</span>'
											+ '<div>'
											+ '<b>전문진료</b>: '
											+ hos_cate
											+ '</div>'
											+ '<div>'
											+ '  <span>'
											+ '<b>진료시간</b>: '
											+ hos_start
											+ '-'
											+ hos_end
											+ '</span>'
											+ ' |'
											+ '  <span>'
											+ '<b>휴일</b>: '
											+ hos_hol
											+ '</span>'
											+ '</div>'
											+ '</div>' + '</div>' + '<hr>';

									li.innerHTML = itemStr;

									document.getElementById('placesList')
											.appendChild(li);

									generateStarRating(number, hos_star);

									if (number == 0) {
										map.setCenter(coords);
									}

								}
							});

		};

		//리스트클릭 시, 해당마커로 이동
		// Modify the moveToMarker function to accept the address as a parameter
		function moveToMarker(divElement) {

			var clickedDivValue = divElement.querySelector('.addr_2_map').innerHTML;
			console.log(clickedDivValue);

			var geocoder = new kakao.maps.services.Geocoder();
			geocoder.addressSearch(clickedDivValue,
					function(result, status) {
						if (status === kakao.maps.services.Status.OK) {
							var coords = new kakao.maps.LatLng(result[0].y,
									result[0].x);
							console.log(coords);
							console.log(map);

							map.setCenter(coords);
						}
					});
		};
	</script>
	<script>
		function TooltipMarker(position, tooltipText) {
			this.position = position;
			var node = this.node = document.createElement('div');
			node.className = 'node';

			var tooltip = document.createElement('div');
			tooltip.className = 'tooltip',

			tooltip.appendChild(document.createTextNode(tooltipText));
			node.appendChild(tooltip);

			// 툴팁 엘리먼트에 마우스 인터렉션에 따라 보임/숨김 기능을 하도록 이벤트를 등록합니다.
			node.onmouseover = function() {
				tooltip.style.display = 'block';
			};
			node.onmouseout = function() {
				tooltip.style.display = 'none';
			};
		}

		// AbstractOverlay 상속. 프로토타입 체인을 연결합니다.
		TooltipMarker.prototype = new kakao.maps.AbstractOverlay;

		// AbstractOverlay의 필수 구현 메소드.
		// setMap(map)을 호출했을 경우에 수행됩니다.
		// AbstractOverlay의 getPanels() 메소드로 MapPanel 객체를 가져오고
		// 거기에서 오버레이 레이어를 얻어 생성자에서 만든 엘리먼트를 자식 노드로 넣어줍니다.
		TooltipMarker.prototype.onAdd = function() {
			var panel = this.getPanels().overlayLayer;
			panel.appendChild(this.node);
		};

		// AbstractOverlay의 필수 구현 메소드.
		// setMap(null)을 호출했을 경우에 수행됩니다.
		// 생성자에서 만든 엘리먼트를 오버레이 레이어에서 제거합니다.
		TooltipMarker.prototype.onRemove = function() {
			this.node.parentNode.removeChild(this.node);
		};

		// AbstractOverlay의 필수 구현 메소드.
		// 지도의 속성 값들이 변화할 때마다 호출됩니다. (zoom, center, mapType)
		// 엘리먼트의 위치를 재조정 해 주어야 합니다.
		TooltipMarker.prototype.draw = function() {
			// 화면 좌표와 지도의 좌표를 매핑시켜주는 projection객체
			var projection = this.getProjection();

			// overlayLayer는 지도와 함께 움직이는 layer이므로
			// 지도 내부의 위치를 반영해주는 pointFromCoords를 사용합니다.
			var point = projection.pointFromCoords(this.position);

			// 내부 엘리먼트의 크기를 얻어서
			var width = this.node.offsetWidth;
			var height = this.node.offsetHeight;

			// 해당 위치의 정중앙에 위치하도록 top, left를 지정합니다.
			this.node.style.left = (point.x - width / 2) + "px";
			this.node.style.top = (point.y - height / 2) + "px";
		};

		// 좌표를 반환하는 메소드
		TooltipMarker.prototype.getPosition = function() {
			return this.position;
		};

		/**
		 * 지도 영역 외부에 존재하는 마커를 추적하는 기능을 가진 객체입니다.
		 * 클리핑 알고리즘을 사용하여 tracker의 좌표를 구하고 있습니다.
		 */
		function MarkerTracker(map, target, name) {
			var hos_name_mark = name;
			// 클리핑을 위한 outcode
			var OUTCODE = {
				INSIDE : 0, // 0b0000
				TOP : 8, //0b1000
				RIGHT : 2, // 0b0010
				BOTTOM : 4, // 0b0100
				LEFT : 1
			// 0b0001
			};

			// viewport 영역을 구하기 위한 buffer값
			// target의 크기가 60x60 이므로 
			// 여기서는 지도 bounds에서 상하좌우 30px의 여분을 가진 bounds를 구하기 위해 사용합니다.
			var BOUNDS_BUFFER = 30;

			// 클리핑 알고리즘으로 tracker의 좌표를 구하기 위한 buffer값
			// 지도 bounds를 기준으로 상하좌우 buffer값 만큼 축소한 내부 사각형을 구하게 됩니다.
			// 그리고 그 사각형으로 target위치와 지도 중심 사이의 선을 클리핑 합니다.
			// 여기서는 tracker의 크기를 고려하여 40px로 잡습니다.
			var CLIP_BUFFER = 40;

			// tracker 엘리먼트
			var tracker = document.createElement('div');
			tracker.className = 'tracker';

			// 내부 아이콘
			var icon = document.createElement('div');
			icon.className = 'icon text-center';
			icon.innerText = hos_name_mark;

			// 외부에 있는 target의 위치에 따라 회전하는 말풍선 모양의 엘리먼트
			var balloon = document.createElement('div');
			balloon.className = 'balloon';

			tracker.appendChild(balloon);
			tracker.appendChild(icon);

			map.getNode().appendChild(tracker);

			// traker를 클릭하면 target의 위치를 지도 중심으로 지정합니다.
			tracker.onclick = function() {
				map.setCenter(target.getPosition());
				setVisible(false);
			};

			// target의 위치를 추적하는 함수
			function tracking() {
				var proj = map.getProjection();

				// 지도의 영역을 구합니다.
				var bounds = map.getBounds();

				// 지도의 영역을 기준으로 확장된 영역을 구합니다.
				var extBounds = extendBounds(bounds, proj);

				// target이 확장된 영역에 속하는지 판단하고
				if (extBounds.contain(target.getPosition())) {
					// 속하면 tracker를 숨깁니다.
					setVisible(false);
				} else {
					// target이 영역 밖에 있으면 계산을 시작합니다.

					// 지도 bounds를 기준으로 클리핑할 top, right, bottom, left를 재계산합니다.
					//
					//  +-------------------------+
					//  | Map Bounds              |
					//  |   +-----------------+   |
					//  |   | Clipping Rect   |   |
					//  |   |                 |   |
					//  |   |        *       (A)  |     A
					//  |   |                 |   |
					//  |   |                 |   |
					//  |   +----(B)---------(C)  |
					//  |                         |
					//  +-------------------------+
					//
					//        B
					//
					//                                       C
					// * 은 지도의 중심,
					// A, B, C가 TooltipMarker의 위치,
					// (A), (B), (C)는 각 TooltipMarker에 대응하는 tracker입니다.
					// 지도 중심과 각 TooltipMarker를 연결하는 선분이 있다고 가정할 때,
					// 그 선분과 Clipping Rect와 만나는 지점의 좌표를 구해서
					// tracker의 위치(top, left)값을 지정해주려고 합니다.
					// tracker 자체의 크기가 있기 때문에 원래 지도 영역보다 안쪽의 가상 영역을 그려
					// 클리핑된 지점을 tracker의 위치로 사용합니다.
					// 실제 tracker의 position은 화면 좌표가 될 것이므로 
					// 계산을 위해 좌표 변환 메소드를 사용하여 모두 화면 좌표로 변환시킵니다.

					// TooltipMarker의 위치
					var pos = proj.containerPointFromCoords(target
							.getPosition());

					// 지도 중심의 위치
					var center = proj.containerPointFromCoords(map.getCenter());

					// 현재 보이는 지도의 영역의 남서쪽 화면 좌표
					var sw = proj.containerPointFromCoords(bounds
							.getSouthWest());

					// 현재 보이는 지도의 영역의 북동쪽 화면 좌표
					var ne = proj.containerPointFromCoords(bounds
							.getNorthEast());

					// 클리핑할 가상의 내부 영역을 만듭니다.
					var top = ne.y + CLIP_BUFFER;
					var right = ne.x - CLIP_BUFFER;
					var bottom = sw.y - CLIP_BUFFER;
					var left = sw.x + CLIP_BUFFER;

					// 계산된 모든 좌표를 클리핑 로직에 넣어 좌표를 얻습니다.
					var clipPosition = getClipPosition(top, right, bottom,
							left, center, pos);

					// 클리핑된 좌표를 tracker의 위치로 사용합니다.
					tracker.style.top = clipPosition.y + 'px';
					tracker.style.left = clipPosition.x + 'px';

					// 말풍선의 회전각을 얻습니다.
					var angle = getAngle(center, pos);

					// 회전각을 CSS transform을 사용하여 지정합니다.
					// 브라우저 종류에따라 표현되지 않을 수도 있습니다.
					// https://caniuse.com/#feat=transforms2d
					balloon.style.cssText += '-ms-transform: rotate(' + angle
							+ 'deg);' + '-webkit-transform: rotate(' + angle
							+ 'deg);' + 'transform: rotate(' + angle + 'deg);';

					// target이 영역 밖에 있을 경우 tracker를 노출합니다.
					setVisible(true);
				}
			}

			// 상하좌우로 BOUNDS_BUFFER(30px)만큼 bounds를 확장 하는 함수
			//
			//  +-----------------------------+
			//  |              ^              |
			//  |              |              |
			//  |     +-----------------+     |
			//  |     |                 |     |
			//  |     |                 |     |
			//  |  <- |    Map Bounds   | ->  |
			//  |     |                 |     |
			//  |     |                 |     |
			//  |     +-----------------+     |
			//  |              |              |
			//  |              v              |
			//  +-----------------------------+
			//  
			// 여기서는 TooltipMaker가 완전히 안보이게 되는 시점의 영역을 구하기 위해서 사용됩니다.
			// TooltipMarker는 60x60 의 크기를 가지고 있기 때문에 
			// 지도에서 완전히 사라지려면 지도 영역을 상하좌우 30px만큼 더 드래그해야 합니다.
			// 이 함수는 현재 보이는 지도 bounds에서 상하좌우 30px만큼 확장한 bounds를 리턴합니다.
			// 이 확장된 영역은 TooltipMarker가 화면에서 보이는지를 판단하는 영역으로 사용됩니다.
			function extendBounds(bounds, proj) {
				// 주어진 bounds는 지도 좌표 정보로 표현되어 있습니다.
				// 이것을 BOUNDS_BUFFER 픽셀 만큼 확장하기 위해서는
				// 픽셀 단위인 화면 좌표로 변환해야 합니다.
				var sw = proj.pointFromCoords(bounds.getSouthWest());
				var ne = proj.pointFromCoords(bounds.getNorthEast());

				// 확장을 위해 각 좌표에 BOUNDS_BUFFER가 가진 수치만큼 더하거나 빼줍니다.
				sw.x -= BOUNDS_BUFFER;
				sw.y += BOUNDS_BUFFER;

				ne.x += BOUNDS_BUFFER;
				ne.y -= BOUNDS_BUFFER;

				// 그리고나서 다시 지도 좌표로 변환한 extBounds를 리턴합니다.
				// extBounds는 기존의 bounds에서 상하좌우 30px만큼 확장된 영역 객체입니다.  
				return new kakao.maps.LatLngBounds(proj.coordsFromPoint(sw),
						proj.coordsFromPoint(ne));

			}

			// Cohen–Sutherland clipping algorithm
			// 자세한 내용은 아래 위키에서...
			// https://en.wikipedia.org/wiki/Cohen%E2%80%93Sutherland_algorithm
			function getClipPosition(top, right, bottom, left, inner, outer) {
				function calcOutcode(x, y) {
					var outcode = OUTCODE.INSIDE;

					if (x < left) {
						outcode |= OUTCODE.LEFT;
					} else if (x > right) {
						outcode |= OUTCODE.RIGHT;
					}

					if (y < top) {
						outcode |= OUTCODE.TOP;
					} else if (y > bottom) {
						outcode |= OUTCODE.BOTTOM;
					}

					return outcode;
				}

				var ix = inner.x;
				var iy = inner.y;
				var ox = outer.x;
				var oy = outer.y;

				var code = calcOutcode(ox, oy);

				while (true) {
					if (!code) {
						break;
					}

					if (code & OUTCODE.TOP) {
						ox = ox + (ix - ox) / (iy - oy) * (top - oy);
						oy = top;
					} else if (code & OUTCODE.RIGHT) {
						oy = oy + (iy - oy) / (ix - ox) * (right - ox);
						ox = right;
					} else if (code & OUTCODE.BOTTOM) {
						ox = ox + (ix - ox) / (iy - oy) * (bottom - oy);
						oy = bottom;
					} else if (code & OUTCODE.LEFT) {
						oy = oy + (iy - oy) / (ix - ox) * (left - ox);
						ox = left;
					}

					code = calcOutcode(ox, oy);
				}

				return {
					x : ox,
					y : oy
				};
			}

			// 말풍선의 회전각을 구하기 위한 함수
			// 말풍선의 anchor가 TooltipMarker가 있는 방향을 바라보도록 회전시킬 각을 구합니다.
			function getAngle(center, target) {
				var dx = target.x - center.x;
				var dy = center.y - target.y;
				var deg = Math.atan2(dy, dx) * 180 / Math.PI;

				return ((-deg + 360) % 360 | 0) + 90;
			}

			// tracker의 보임/숨김을 지정하는 함수
			function setVisible(visible) {
				tracker.style.display = visible ? 'block' : 'none';
			}

			// Map 객체의 'zoom_start' 이벤트 핸들러
			function hideTracker() {
				setVisible(false);
			}

			// target의 추적을 실행합니다.
			this.run = function() {
				kakao.maps.event.addListener(map, 'zoom_start', hideTracker);
				kakao.maps.event.addListener(map, 'zoom_changed', tracking);
				kakao.maps.event.addListener(map, 'center_changed', tracking);
				tracking();
			};

			// target의 추적을 중지합니다.
			this.stop = function() {
				kakao.maps.event.removeListener(map, 'zoom_start', hideTracker);
				kakao.maps.event.removeListener(map, 'zoom_changed', tracking);
				kakao.maps.event
						.removeListener(map, 'center_changed', tracking);
				setVisible(false);
			};
		}
	</script>

	<script>
		//이전별점
		function generateStarRating(idx, starValue) {
			console.log('starValue', starValue);
			for (var i = 1; i <= 5; i++) {
				var starHtml = '';
				starHtml += '<input type="radio" id="' + i
						+ '-stars" name="hos_star" value="' + i + '"';

				if (i <= starValue) {
					if (i == starValue)
						starHtml += ' checked';
					starHtml += ' /><label for="' + i + '-stars" class="star starChk">&#9733;</label>';
				} else {
					starHtml += ' /><label for="' + i + '-stars" class="star">&#9733;</label>';
				}
				$("#st-" + idx).append(starHtml);
			}
		}
	</script>
</body>
</html>