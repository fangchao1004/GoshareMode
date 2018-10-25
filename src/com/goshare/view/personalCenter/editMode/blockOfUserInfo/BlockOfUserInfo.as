package com.goshare.view.personalCenter.editMode.blockOfUserInfo
{
	import com.goshare.components.NewDropList;
	import com.goshare.components.ToggleBtnForGender;
	import com.goshare.data.DataOfPublic;
	import com.goshare.data.UserFormInfo;
	import com.goshare.data.UserInfo;
	import com.goshare.event.TestEvent;
	import com.goshare.manager.EventManager;
	import com.goshare.render.itemRenderForDropList;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import coco.component.Alert;
	import coco.component.Button;
	import coco.component.HorizontalAlign;
	import coco.component.Image;
	import coco.component.Label;
	import coco.component.TextAlign;
	import coco.component.TextInput;
	import coco.core.UIComponent;
	import coco.event.UIEvent;
	import coco.util.FontFamily;
	
	public class BlockOfUserInfo extends UIComponent
	{
		public function BlockOfUserInfo()
		{
			super();
			///加载行政区json文件
			getJSONData();
			EventManager.getInstance().addEventListener("checkFormInfoToSave",checkFormInfoToSave_Handler);
			EventManager.getInstance().addEventListener("getUserInfoFromServer",getUserInfoFromServer_Handler);///进入“个人中心”触发
		}
		
		protected function getUserInfoFromServer_Handler(event:Event):void
		{
			recoverUserInfoData();
			recoverBirthdayData();
			recoverAddressData();
			recoverNativePlaceData();
			recoverFaceData();
			saveUserIdHandler();
			saveSchoolHandler();
		}
		
		private function saveSchoolHandler():void
		{
			if(DataOfPublic.getInstance().allDataByRegsiter["school"]){
				UserFormInfo.school = DataOfPublic.getInstance().allDataByRegsiter["school"];
			}
		}
		
		private function saveUserIdHandler():void
		{
			if(DataOfPublic.getInstance().allDataByRegsiter["userId"]){
				UserFormInfo.userId = DataOfPublic.getInstance().allDataByRegsiter["userId"];
			}
		}
		
		private function recoverUserInfoData():void
		{
			var allData : Object = DataOfPublic.getInstance().allDataByRegsiter;
			if(allData){
				nameTxtInput.text = allData["userName"]
				if(allData["gender"]=="男"){
					toggleForMale.selected =true;
					toggleForFemale.selected = false;
				}else{
					toggleForMale.selected =false;
					toggleForFemale.selected = true;
				}
			}
		}
		
		private function recoverNativePlaceData():void
		{
			if(DataOfPublic.getInstance().allDataByRegsiter["userNativePlace"]){
				var userNativePlaceStr : String = DataOfPublic.getInstance().allDataByRegsiter["userNativePlace"]
				var userNativePlaceArr : Array = userNativePlaceStr.split("-");
				provinceDropList2.text = userNativePlaceArr[0];
				cityDropList2.text = userNativePlaceArr[1];
				areaDropList2.text = userNativePlaceArr[2];
			}
		}
		
		private function recoverAddressData():void
		{
			if(DataOfPublic.getInstance().allDataByRegsiter["userAddress"]){
				var userAddressStr : String = DataOfPublic.getInstance().allDataByRegsiter["userAddress"]
				var userAddressArr : Array = userAddressStr.split("-");
				provinceDropList1.text = userAddressArr[0];
				cityDropList1.text = userAddressArr[1];
				areaDropList1.text = userAddressArr[2];
			}
		}
		
		private function recoverBirthdayData():void
		{
			if(DataOfPublic.getInstance().allDataByRegsiter["userBirthday"]){
				var userBirthdayStr : String = DataOfPublic.getInstance().allDataByRegsiter["userBirthday"]
				var userBirthdayArr : Array = userBirthdayStr.split("-");
				yearDropList.text = userBirthdayArr[0];
				monthDropList.text = userBirthdayArr[1];
				dateDropList.text = userBirthdayArr[2];
			}
		}
		
		/**
		 * 恢复照片位图---根据服务端获取的数据
		 */
		public function recoverFaceData():void
		{
			///UserInfo.userFaceBitmapData是注册是保存的位图数据
			/*if(UserInfo.userFaceBitmapData){
			headImage.bitmapData = UserInfo.userFaceBitmapData
			}else{
			trace("UserInfo.userFaceBitmapData : 不存在？不显示用户照片");
			}*/
			
			if(DataOfPublic.getInstance().allDataByRegsiter["userFace"]){
				trace("	获取到userFace的url地址数据");
				var faceData : String = DataOfPublic.getInstance().allDataByRegsiter["userFace"];
				UserFormInfo.userFace = faceData;
				headImage.source = faceData;
//				headImage.source = "http://pic35.photophoto.cn/20150528/0005018363609539_b.jpg";
			}
		}
		
		private function getJSONData():void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.load(new URLRequest( "assets/district.json"));//这里是要获取JSON的路径
			urlLoader.addEventListener(Event.COMPLETE, urlLoader_completeHandler);
		}
		
		private var districtsArray1:Array
		private var provinceArray1 : Array;
		private var cityArray1 : Array;
		private var areaArray1 : Array;
		
		private var districtsArray2:Array
		private var provinceArray2 : Array;
		private var cityArray2 : Array;
		private var areaArray2 : Array;
		
		protected function urlLoader_completeHandler(event:Event):void
		{
			districtsArray1 = [];
			provinceArray1 = [];
			cityArray1 = [];
			areaArray1 = [];
			
			districtsArray2 = [];
			provinceArray2 = [];
			cityArray2 = [];
			areaArray2 = [];
			
			//			trace("行政区数据加载成功");
			///获取到所有数据
			districtsArray1 = JSON.parse(event.currentTarget.data) as Array;
			districtsArray2 = districtsArray1;
			
			///获取直辖市省级行政区数组
			for each (var i:Object in districtsArray1) {
				provinceArray1.push(i["name"]);
			}
			
			provinceArray2 = provinceArray1;
			//			trace("provinceArray1直辖市省级行政区数组: "+JSON.stringify(provinceArray1));
			//			trace("provinceArray2直辖市省级行政区数组: "+JSON.stringify(provinceArray2));
			
			///查询安徽省的城市
			//			for each (var proviceOBj:Object in districtsArray1) 
			//			{
			//				if(proviceOBj["name"]=="安徽省"){
			//					cityArray1 = proviceOBj["city"];
			//					trace("安徽省有以下市和区："+JSON.stringify(cityArray1));
			//				}
			//			}
			//			for each (var cityObject:Object in cityArray1) 
			//			{
			//				if(cityObject["name"]=="宣城市"){
			//					areaArray1 = cityObject["area"];
			//					trace("宣城市以下县和区："+JSON.stringify(areaArray1));
			//				}
			//			}
			invalidateProperties();
		}
		
		private var iconLab : Label;
		private var headImage : Image;
		private var coverIcon : Image;
		private var cameraBtn : Button;
		private var nameLab : Label;
		private var nameTxtInput : TextInput;
		private var genderLab : Label;
		private var toggleForMale : ToggleBtnForGender;
		private var toggleForFemale : ToggleBtnForGender;
		private var birthLab : Label;
		private var yearDropList : NewDropList;
		private var monthDropList : NewDropList;
		private var dateDropList : NewDropList;
		
		private var addressLab : Label;
		private var provinceDropList1 : NewDropList;  ///居住地
		private var cityDropList1 : NewDropList;
		private var areaDropList1 : NewDropList;
		
		private var nativePlaceLab : Label;
		private var provinceDropList2 : NewDropList;///籍贯
		private var cityDropList2 : NewDropList;
		private var areaDropList2 : NewDropList;
		
		/**是否为闰年*/		
		private var isLeapYearFlag : Boolean;
		private var dateDataArray : Array = [];
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			iconLab = new Label();
			iconLab.fontSize = 16;
			iconLab.text = "头    像：";
			iconLab.bold = true;
			iconLab.fontFamily = FontFamily.STXIHEI;
			addChild(iconLab);
			
			headImage = new Image();
			addChild(headImage);
			
			coverIcon = new Image();
			coverIcon.source = "assets/regsiter/cover.png";
			addChild(coverIcon);
			
			cameraBtn = new Button();
			//			cameraBtn.autoDrawSkin = false;
			cameraBtn.label = "重新上传";
			cameraBtn.fontSize = 18;
			cameraBtn.fontFamily = FontFamily.STXIHEI;
			cameraBtn.radius = 8;
			cameraBtn.borderThickness = 0;
			cameraBtn.backgroundColor = 0xf6f5f5;
			cameraBtn.color = 0x949494;
			addChild(cameraBtn);
			
			nameLab  = new Label();
			nameLab.fontSize = 16;
			nameLab.text = "姓    名：";
			nameLab.bold = true;
			nameLab.fontFamily = FontFamily.STXIHEI;
			addChild(nameLab);
			
			nameTxtInput = new TextInput();
			nameTxtInput.borderAlpha = 0;
			nameTxtInput.textAlign = TextAlign.CENTER;
			nameTxtInput.height = 36;
			nameTxtInput.width = 375;
			nameTxtInput.radius = 10;
			nameTxtInput.backgroundColor = 0xf6f5f5;
			nameTxtInput.color = 0x8c8c8c;
			nameTxtInput.fontSize = 18;
			nameTxtInput.fontFamily = FontFamily.STXIHEI;
			nameTxtInput.addEventListener(UIEvent.CHANGE,changeName_Handler);
			addChild(nameTxtInput);
			
			genderLab = new Label();
			genderLab.fontSize = 16;
			genderLab.text = "性    别：";
			genderLab.bold = true;
			genderLab.fontFamily = FontFamily.STXIHEI;
			addChild(genderLab);
			
			toggleForMale  = new ToggleBtnForGender();
			toggleForMale.buttonMode = true;
			toggleForMale.txtLab = "男";
			toggleForMale.selected = true;
			toggleForMale.drawRadius = 5;
			toggleForMale.height = 24;
			toggleForMale.width = 100;
			toggleForMale.labX = 40;
			toggleForMale.labY = 0;
			toggleForMale.addEventListener(MouseEvent.CLICK,maleHandler);
			addChild(toggleForMale);
			
			toggleForFemale  = new ToggleBtnForGender();
			toggleForFemale.buttonMode = true;
			toggleForFemale.txtLab = "女";
			toggleForFemale.selected = false;
			toggleForFemale.drawRadius = 5;
			toggleForFemale.height = 24;
			toggleForFemale.width = 100;
			toggleForFemale.labX = 40;
			toggleForFemale.labY = 0;
			toggleForFemale.addEventListener(MouseEvent.CLICK,femaleHandler);
			addChild(toggleForFemale);
			
			birthLab = new Label();
			birthLab.fontSize = 16;
			birthLab.text = "生    日：";
			birthLab.bold = true;
			birthLab.fontFamily = FontFamily.STXIHEI;
			addChild(birthLab);
			
			yearDropList = new NewDropList();
			yearDropList.labWidth = 30;
			yearDropList.labText = "年";
			yearDropList.MytextAlign = HorizontalAlign.LEFT;
			yearDropList.buttonMode = true;
			yearDropList.height = 36;
			yearDropList.width = 85;
			yearDropList.topRightRadius = yearDropList.bottomRightRadius = 10;
			yearDropList.backgroundColor = 0xf6f5f5;
			yearDropList.itemRendererClass = itemRenderForDropList;
			yearDropList.fontFamily = FontFamily.STXIHEI;
			yearDropList.fontSize = 16;
			yearDropList.color = 0x949494;
			yearDropList.dataProvider = DataOfPublic.getInstance().yearDataArray;
			yearDropList.addEventListener(UIEvent.CHANGE,yearDropList_Handler);
			addChild(yearDropList);
			
			monthDropList = new NewDropList();
			monthDropList.labWidth = 30;
			monthDropList.labText = "月";
			monthDropList.MytextAlign = HorizontalAlign.LEFT;
			monthDropList.buttonMode = true;
			monthDropList.height = 36;
			monthDropList.width = 85;
			monthDropList.topRightRadius = monthDropList.bottomRightRadius = 10;
			monthDropList.backgroundColor = 0xf6f5f5;
			monthDropList.itemRendererClass = itemRenderForDropList;
			monthDropList.fontFamily = FontFamily.STXIHEI;
			monthDropList.fontSize = 16;
			monthDropList.color = 0x949494;
			monthDropList.dataProvider = ["1","2","3","4","5","6","7","8","9","10","11","12"];
			monthDropList.selectedIndex = -1;
			monthDropList.addEventListener(UIEvent.CHANGE,monthDropList_Handler);
			addChild(monthDropList);
			
			dateDropList = new NewDropList();
			dateDropList.labWidth = 30;
			dateDropList.labText = "日";
			dateDropList.MytextAlign = HorizontalAlign.LEFT;
			dateDropList.buttonMode = true;
			dateDropList.height = 36;
			dateDropList.width = 85;
			dateDropList.topRightRadius = dateDropList.bottomRightRadius = 10;
			dateDropList.backgroundColor = 0xf6f5f5;
			dateDropList.itemRendererClass = itemRenderForDropList;
			dateDropList.fontFamily = FontFamily.STXIHEI;
			dateDropList.fontSize = 16;
			dateDropList.color = 0x949494;
			dateDropList.selectedIndex = 0;
			dateDropList.dataProvider = [];
			dateDropList.addEventListener(UIEvent.CHANGE,dateDropList_Handler);
			addChild(dateDropList);
			
			addressLab = new Label();
			addressLab.fontSize = 16;
			addressLab.text = "居住地：";
			addressLab.bold = true;
			addressLab.fontFamily = FontFamily.STXIHEI;
			addChild(addressLab);
			
			provinceDropList1 = new NewDropList();
			provinceDropList1.labWidth = 30;
			provinceDropList1.labText = "省";
			provinceDropList1.MytextAlign = HorizontalAlign.LEFT;
			provinceDropList1.buttonMode = true;
			provinceDropList1.height = 36;
			provinceDropList1.width = 85;
			provinceDropList1.topRightRadius = dateDropList.bottomRightRadius = 10;
			provinceDropList1.backgroundColor = 0xf6f5f5;
			provinceDropList1.itemRendererClass = itemRenderForDropList;
			provinceDropList1.fontFamily = FontFamily.STXIHEI;
			provinceDropList1.fontSize = 16;
			provinceDropList1.color = 0x949494;
			provinceDropList1.dataProvider = [];
			provinceDropList1.addEventListener(UIEvent.CHANGE,provinceDropList1_Handler);
			addChild(provinceDropList1);
			
			cityDropList1 = new NewDropList();
			cityDropList1.labWidth = 30;
			cityDropList1.labText = "市";
			cityDropList1.MytextAlign = HorizontalAlign.LEFT;
			cityDropList1.buttonMode = true;
			cityDropList1.height = 36;
			cityDropList1.width = 85;
			cityDropList1.topRightRadius = dateDropList.bottomRightRadius = 10;
			cityDropList1.backgroundColor = 0xf6f5f5;
			cityDropList1.itemRendererClass = itemRenderForDropList;
			cityDropList1.fontFamily = FontFamily.STXIHEI;
			cityDropList1.fontSize = 16;
			cityDropList1.color = 0x949494;
			cityDropList1.dataProvider = [];
			cityDropList1.addEventListener(UIEvent.CHANGE,cityDropList1_Handler);
			addChild(cityDropList1);
			
			areaDropList1 = new NewDropList();
			areaDropList1.labWidth = 30;
			areaDropList1.labText = "区";
			areaDropList1.MytextAlign = HorizontalAlign.LEFT;
			areaDropList1.buttonMode = true;
			areaDropList1.height = 36;
			areaDropList1.width = 85;
			areaDropList1.topRightRadius = dateDropList.bottomRightRadius = 10;
			areaDropList1.backgroundColor = 0xf6f5f5;
			areaDropList1.itemRendererClass = itemRenderForDropList;
			areaDropList1.fontFamily = FontFamily.STXIHEI;
			areaDropList1.fontSize = 16;
			areaDropList1.color = 0x949494;
			areaDropList1.dataProvider = [];
			areaDropList1.addEventListener(UIEvent.CHANGE,changeArea1_Handler);
			addChild(areaDropList1);
			
			nativePlaceLab = new Label();
			nativePlaceLab.fontSize = 16;
			nativePlaceLab.text = "籍    贯：";
			nativePlaceLab.bold = true;
			nativePlaceLab.fontFamily = FontFamily.STXIHEI;
			addChild(nativePlaceLab);
			
			provinceDropList2 = new NewDropList();
			provinceDropList2.labWidth = 30;
			provinceDropList2.labText = "省";
			provinceDropList2.MytextAlign = HorizontalAlign.LEFT;
			provinceDropList2.buttonMode = true;
			provinceDropList2.height = 36;
			provinceDropList2.width = 85;
			provinceDropList2.topRightRadius = dateDropList.bottomRightRadius = 10;
			provinceDropList2.backgroundColor = 0xf6f5f5;
			provinceDropList2.itemRendererClass = itemRenderForDropList;
			provinceDropList2.fontFamily = FontFamily.STXIHEI;
			provinceDropList2.fontSize = 16;
			provinceDropList2.color = 0x949494;
			provinceDropList2.dataProvider = [];
			provinceDropList2.addEventListener(UIEvent.CHANGE,provinceDropList2_Handler);
			addChild(provinceDropList2);
			
			cityDropList2 = new NewDropList();
			cityDropList2.labWidth = 30;
			cityDropList2.labText = "市";
			cityDropList2.MytextAlign = HorizontalAlign.LEFT;
			cityDropList2.buttonMode = true;
			cityDropList2.height = 36;
			cityDropList2.width = 85;
			cityDropList2.topRightRadius = dateDropList.bottomRightRadius = 10;
			cityDropList2.backgroundColor = 0xf6f5f5;
			cityDropList2.itemRendererClass = itemRenderForDropList;
			cityDropList2.fontFamily = FontFamily.STXIHEI;
			cityDropList2.fontSize = 16;
			cityDropList2.color = 0x949494;
			cityDropList2.dataProvider = [];
			cityDropList2.addEventListener(UIEvent.CHANGE,cityDropList2_Handler);
			addChild(cityDropList2);
			
			areaDropList2 = new NewDropList();
			areaDropList2.labWidth = 30;
			areaDropList2.labText = "区";
			areaDropList2.MytextAlign = HorizontalAlign.LEFT;
			areaDropList2.buttonMode = true;
			areaDropList2.height = 36;
			areaDropList2.width = 85;
			areaDropList2.topRightRadius = dateDropList.bottomRightRadius = 10;
			areaDropList2.backgroundColor = 0xf6f5f5;
			areaDropList2.itemRendererClass = itemRenderForDropList;
			areaDropList2.fontFamily = FontFamily.STXIHEI;
			areaDropList2.fontSize = 16;
			areaDropList2.color = 0x949494;
			areaDropList2.dataProvider = [];
			areaDropList2.addEventListener(UIEvent.CHANGE,changeArea2_Handler);
			addChild(areaDropList2);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			getProvinceData();
		}
		
		override protected function updateDisplayList():void
		{
			super.updateDisplayList();
			
			iconLab.x = 0;
			iconLab.y = 30;
			
			headImage.width = headImage.height = coverIcon.width = coverIcon.height = 80;
			headImage.x=coverIcon.x = iconLab.x+80;
			headImage.y=coverIcon.y = 0;
			
			cameraBtn.height = 40;
			cameraBtn.width = 100;
			cameraBtn.x = coverIcon.x + coverIcon.width + 20;
			cameraBtn.y = iconLab.y-(cameraBtn.height-iconLab.fontSize)/2;
			
			nameLab.x = iconLab.x;
			nameLab.y = iconLab.y+80;
			nameTxtInput.x = coverIcon.x;
			nameTxtInput.y = nameLab.y-7;
			
			genderLab.x = iconLab.x;
			genderLab.y = nameLab.y+60;
			
			toggleForMale.x = coverIcon.x;
			toggleForFemale.x = toggleForMale.x + 200;
			toggleForMale.y = genderLab.y;
			toggleForFemale.y = toggleForMale.y;
			
			birthLab.x = iconLab.x;
			birthLab.y = genderLab.y+60;
			
			yearDropList.x = coverIcon.x+yearDropList.labWidth;
			yearDropList.y = birthLab.y-7;
			
			monthDropList.x = yearDropList.x+yearDropList.labWidth+yearDropList.width+15;
			monthDropList.y = yearDropList.y;
			
			dateDropList.x = monthDropList.x+monthDropList.labWidth+monthDropList.width+15;
			dateDropList.y = monthDropList.y;
			
			addressLab.x = iconLab.x;
			addressLab.y = birthLab.y+60;
			
			provinceDropList1.x = coverIcon.x+provinceDropList1.labWidth;
			provinceDropList1.y = addressLab.y-7;
			
			cityDropList1.x = provinceDropList1.x+provinceDropList1.labWidth+provinceDropList1.width+15;
			cityDropList1.y = provinceDropList1.y;
			
			areaDropList1.x = cityDropList1.x+cityDropList1.labWidth+cityDropList1.width+15;
			areaDropList1.y = provinceDropList1.y;
			
			nativePlaceLab.x = iconLab.x;
			nativePlaceLab.y = addressLab.y+60;
			
			provinceDropList2.x = coverIcon.x+provinceDropList2.labWidth;
			provinceDropList2.y = nativePlaceLab.y-7;
			
			cityDropList2.x = provinceDropList2.x+provinceDropList2.labWidth+provinceDropList2.width+15;
			cityDropList2.y = provinceDropList2.y;
			
			areaDropList2.x = cityDropList2.x+cityDropList2.labWidth+cityDropList2.width+15;
			areaDropList2.y = provinceDropList2.y;
		}
		
		protected function femaleHandler(event:MouseEvent):void
		{
			if(!event.currentTarget.selected)
			{
				event.currentTarget.selected = true;
				toggleForMale.selected = false;
				UserFormInfo.userGender = "女";
			}
		}
		
		protected function maleHandler(event:MouseEvent):void
		{
			if(!event.currentTarget.selected)
			{
				event.currentTarget.selected = true;
				toggleForFemale.selected = false;
				UserFormInfo.userGender = "男";
			}
		}
		
		private function getProvinceData():void
		{
			provinceDropList1.dataProvider = provinceArray1;
			provinceDropList2.dataProvider = provinceArray2;
		}
		
		protected function cityDropList2_Handler(event:UIEvent):void
		{
			resetAreaSelected(2);
			if(cityDropList2.text){
				getAreaArray(cityDropList2.text,2);
			}else{
				areaDropList2.dataProvider = [];
			}
		}	
		
		protected function cityDropList1_Handler(event:UIEvent):void
		{
			resetAreaSelected(1);
			if(cityDropList1.text){
				getAreaArray(cityDropList1.text,1);
			}else{
				areaDropList1.dataProvider = [];
			}
		}
		
		protected function provinceDropList2_Handler(event:UIEvent):void
		{
			resetCitySelected(2);
			resetAreaSelected(2);
			if(provinceDropList2.text){
				getCityArray(provinceDropList2.text,2)
			}else{
				cityDropList2.dataProvider = [];
			}
		}
		
		protected function provinceDropList1_Handler(event:UIEvent):void
		{
			resetCitySelected(1);
			resetAreaSelected(1);
			if(provinceDropList1.text){
				getCityArray(provinceDropList1.text,1)
			}else{
				cityDropList1.dataProvider = [];
			}
		}
		
		private function resetCitySelected(num:int):void
		{
			if(num==1){
				cityDropList1.text = "";
				cityDropList1.selectedIndex = -1;
			}else if(num==2){
				cityDropList2.text = "";
				cityDropList2.selectedIndex = -1;
			}
		}	
		
		private function resetAreaSelected(num:int):void
		{
			if(num==1){
				areaDropList1.text = "";
				areaDropList1.selectedIndex = -1;
			}else if(num==2){
				areaDropList2.text = "";
				areaDropList2.selectedIndex = -1;
			}
		}
		
		private function getCityArray(text:String,num:int):void
		{
			if(num==1){
				cityArray1 = [];
				var cityNameArray1 : Array = [];
				for each (var proviceOBj1:Object in districtsArray1) 
				{
					if(proviceOBj1["name"]==text){
						cityArray1 = proviceOBj1["city"];
						//						trace(text+"有以下市："+JSON.stringify(cityArray1));
						for each (var cityAllData1:Object in cityArray1) 
						{
							cityNameArray1.push(cityAllData1["name"]);
						}
						//						trace(text+"有以下市名称："+JSON.stringify(cityNameArray1));
						cityDropList1.dataProvider = cityNameArray1;
					}
				}
			}else if(num==2){
				cityArray2 = [];
				var cityNameArray2 : Array = [];
				for each (var proviceOBj2:Object in districtsArray2) 
				{
					if(proviceOBj2["name"]==text){
						cityArray2 = proviceOBj2["city"];
						//						trace(text+"有以下市："+JSON.stringify(cityArray2));
						for each (var cityAllData2:Object in cityArray2) 
						{
							cityNameArray2.push(cityAllData2["name"]);
						}
						//						trace(text+"有以下市名称："+JSON.stringify(cityNameArray2));
						cityDropList2.dataProvider = cityNameArray2;
					}
				}
			}
		}	
		
		private function getAreaArray(text:String,num:int):void
		{
			if(num==1){
				for each (var cityObject1:Object in cityArray1) 
				{
					if(cityObject1["name"]==text){
						areaArray1 = cityObject1["area"];
						//						trace(text+"有以下县和区："+JSON.stringify(areaArray1));
						areaDropList1.dataProvider = areaArray1;
					}
				}
			}else if(num==2){
				for each (var cityObject2:Object in cityArray2) 
				{
					if(cityObject2["name"]==text){
						areaArray2 = cityObject2["area"];
						//						trace(text+"有以下县和区："+JSON.stringify(areaArray2));
						areaDropList2.dataProvider = areaArray2;
					}
				}
			}
		}
		
		/****************************************************************/	
		/****************************************************************/		
		/****************************************************************/		
		
		///选则年
		protected function yearDropList_Handler(event:UIEvent):void
		{
			///重置月-日
			resetMonth();
			resetDate();
			
			var yearNumber : int = parseInt(yearDropList.text);
			isLeapYearFlag = checkYearIsLeap(yearNumber)
			
			///trace(yearDropList.text,"闰年",isLeapYearFlag);
			checkSelectedMonth();
		}
		/**重置月份*/
		private function resetMonth():void
		{
			monthDropList.text = "";
			monthDropList.selectedIndex = -1;
		}
		/**重置日期*/
		private function resetDate():void
		{
			dateDropList.text = "";
			dateDropList.selectedIndex = -1;
		}
		
		/**
		 * 检查选中的月份
		 */
		private function checkSelectedMonth():void
		{
			if(!isLeapYearFlag&&monthDropList.text=="2"){
				resetDate();
				getDateData(28);
			}else if(isLeapYearFlag&&monthDropList.text=="2"){
				resetDate();
				getDateData(29);
			}
		}
		
		///选则月
		protected function monthDropList_Handler(event:UIEvent):void
		{
			if(yearDropList.text){
				if(isLeapYearFlag&&monthDropList.text=="2"){
					getDateData(29)
				}else if(!isLeapYearFlag&&monthDropList.text=="2"){
					getDateData(28)
				}else if(monthDropList.text=="1"||monthDropList.text=="3"||monthDropList.text=="5"
					||monthDropList.text=="7"||monthDropList.text=="8"||monthDropList.text=="10"||monthDropList.text=="12"){
					getDateData(31)
				}else if(monthDropList.text=="4"||monthDropList.text=="6"||monthDropList.text=="9"||monthDropList.text=="11"){
					getDateData(30)
				}
			}else{
				resetMonth();
				resetDate();
				Alert.show("请先选择年份");
				return;
			}
		}
		
		///设置日期的数量
		private function getDateData(dateNumber:Number):void
		{
			resetDate();
			dateDataArray = [];
			for (var i:int = 1; i <=dateNumber; i++) {
				dateDataArray.push(i+"")
			}
			dateDropList.dataProvider = dateDataArray;
		}
		
		///选则日
		protected function dateDropList_Handler(event:UIEvent):void
		{
			///年月日选则完毕后
			saveYearMonthDate();
		}	
		
		private function saveYearMonthDate():void
		{
			///保存年月日数据
			if(yearDropList.text==""||monthDropList.text==""||dateDropList.text==""){
				UserFormInfo.userBirthday = null;
			}else{
				UserFormInfo.userBirthday = yearDropList.text+"-"+monthDropList.text+"-"+dateDropList.text;
			}
//			trace("UserFormInfo.userBirthday: "+UserFormInfo.userBirthday);
		}
		
		/**
		 *判断是否是闰年
		 */
		private function checkYearIsLeap(yearNumber:int):Boolean
		{
			if (((yearNumber % 4)==0) && ((yearNumber % 100)!=0) || ((yearNumber % 400)==0)) {
				return (true);
			} else { return (false); }
		}
		
		
		/****************************************************************/	
		/****************************************************************/		
		/****************************************************************/		
		
		protected function changeName_Handler(event:UIEvent):void
		{
			if(nameTxtInput.text){
				UserFormInfo.userName = nameTxtInput.text;
			}else{
				Alert.show("请输入正确的姓名");
				nameTxtInput.text = DataOfPublic.getInstance().allDataByRegsiter["userName"];
			}
		}
		////住址
		protected function changeArea1_Handler(event:UIEvent):void
		{
			if(provinceDropList1.text!=""&&cityDropList1.text!=""&&areaDropList1.text!=""){
				saveAddressData();
			}
		}	
		
		private function saveAddressData():void
		{
			if(provinceDropList1.text==""||cityDropList1.text==""||areaDropList1.text==""){
				UserFormInfo.userAddress = null;
			}else{
				UserFormInfo.userAddress = provinceDropList1.text+"-"+cityDropList1.text+"-"+areaDropList1.text;
			}
//			trace("UserFormInfo.userAddress："+UserFormInfo.userAddress);
		}
		
		///籍贯
		protected function changeArea2_Handler(event:UIEvent):void
		{
			if(provinceDropList2.text!=""&&cityDropList2.text!=""&&areaDropList2.text!=""){
				saveNativePlaceData();
			}
		}		
		
		private function saveNativePlaceData():void
		{
			if(provinceDropList2.text==""||cityDropList2.text==""||areaDropList2.text==""){
				UserFormInfo.userNativePlace = null;
			}else{
				UserFormInfo.userNativePlace = provinceDropList2.text+"-"+cityDropList2.text+"-"+areaDropList2.text;
			}
//			trace("UserFormInfo.userNativePlace："+UserFormInfo.userNativePlace);
		}
		
		private function saveNameData():void
		{
			UserFormInfo.userName = nameTxtInput.text;
		}
		
		private function saveGenderData():void
		{
			UserFormInfo.userGender = toggleForMale.selected?"男":"女";
		}	
		
		private function saveFaceData():void
		{
			
		}
		
		/**
		 * 监听到 点击保存后 再保存一次数据
		 * 主要是将各个组件的选中情况，进行一次整理赋值到UserFormInfo类中
		 */
		protected function checkFormInfoToSave_Handler(e:TestEvent):void
		{
			saveFaceData();
			saveNameData();
			saveGenderData();
			saveNativePlaceData();
			saveAddressData();
			saveYearMonthDate();
		}
		
	}
}