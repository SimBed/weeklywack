function setUse(){
	setCookie();
	enableBtn();
	setTermsHeadline();
	}
	
function setCookie(){
	 /*var use = document.getElementById('Use').value;*/
	 var use = getSelectedText('Use');
     document.cookie = "Use=" + use + "; path=/";
}	

function setTermsHeadline() {

	/*var use = document.getElementById('Use').value;*/
	var use = getSelectedText('Use');
	/*variables eg basement, peak*/
	var priceBP;
	var priceBO;
	var priceFP;
	var priceFO;
	var priceGP;
	var priceGO;
	
	/* Regular Class*/
	var priceRegBP = "2,725";
	var priceRegBO = "1,500";
	var priceRegFP = "1,425";
	var priceRegFO = "1,425";
	var priceRegGP = "1,000";
	var priceRegGO = "1,000";
	
	/* Workshops*/
	var priceWBP = "3,200";
	var priceWBO = "3,200";
	var priceWFP = "2,000";
	var priceWFO = "2,000";
	var priceWGP = "1,500";
	var priceWGO = "1,500";
	
	/* Personal Training*/
	var pricePTBP = "1,770";
	var pricePTBO = "1,770";
	var pricePTFP = "1,770";
	var pricePTFO = "1,770";
	var pricePTGP = "1,000";
	var pricePTGO = "1,000";
	
	/*Rehearsal (TV,Film,Event)*/
	var priceRehBP = "3,200";
	var priceRehBO = "3,200";
	var priceRehFP = "2,360";
	var priceRehFO = "2,360";
	var priceRehGP = "1,500";
	var priceRehGO = "1,500";
	
	/*Private Event*/
	var pricePEBP = "2,950";
	var pricePEBO = "2,950";
	var pricePEFP = "2,360";
	var pricePEFO = "2,360";
	var pricePEGP = "2,360";
	var pricePEGO = "2,360";
/*pre Dec 2018
	var pricePEFP = "1,770";
	var pricePEFO = "1,770";
	var pricePEGP = "1,300";
	var pricePEGO = "1,300";*/
	
	/*Shooting
	var priceShBP = "2,950";
	var priceShBO = "2,950";
	var priceShFP = "1,770";
	var priceShFO = "1,770";
	var priceShGP = "1,300";
	var priceShGO = "1,300";*/
	
	/*not applicable if no option selected*/
	var na = "-";
	
	/*collect spans and table rows relevant to peak hours (so regular class only)*/
	peakspan = document.getElementsByClassName("PeakSpanDisplay");
	peakrow = document.getElementsByClassName("PeakRowDisplay");
	
	switch (use) {
    case "Regular Class":
        priceBP = priceRegBP;
		priceBO = priceRegBO;
		priceFP = priceRegFP;
		priceFO = priceRegFO;
		priceGP = priceRegGP;
		priceGO = priceRegGO;
		for (var i = 0; i < peakspan.length; i++) {
        peakspan[i].style.display="inline";
		}
		for (var i = 0; i < peakrow.length; i++) {
        peakrow[i].style.display="table-row";
		}
        break;
    case "Workshop":
        priceBP = priceWBP;
		priceBO = priceWBO;
		priceFP = priceWFP;
		priceFO = priceWFO;
		priceGP = priceWGP;
		priceGO = priceWGO;
		for (var i = 0; i < peakspan.length; i++) {
        peakspan[i].style.display="none";
		}
		for (var i = 0; i < peakrow.length; i++) {
        peakrow[i].style.display="none";
		}
        break;
    case "Personal Training":
        priceBP = pricePTBP;
		priceBO = pricePTBO;
		priceFP = pricePTFP;
		priceFO = pricePTFO;
		priceGP = pricePTGP;
		priceGO = pricePTGO;
		for (var i = 0; i < peakspan.length; i++) {
        peakspan[i].style.display="none";
		}
		for (var i = 0; i < peakrow.length; i++) {
        peakrow[i].style.display="none";
		}		
		break;
	case "Rehearsal-TV,Film,Event":
        priceBP = priceRehBP;
		priceBO = priceRehBO;
		priceFP = priceRehFP;
		priceFO = priceRehFO;
		priceGP = priceRehGP;
		priceGO = priceRehGO;
		for (var i = 0; i < peakspan.length; i++) {
        peakspan[i].style.display="none";
		}
		for (var i = 0; i < peakrow.length; i++) {
        peakrow[i].style.display="none";
		}
		break;
	case "Private Event":
        priceBP = pricePEBP;
		priceBO = pricePEBO;
		priceFP = pricePEFP;
		priceFO = pricePEFO;
		priceGP = pricePEGP;
		priceGO = pricePEGO;
		for (var i = 0; i < peakspan.length; i++) {
        peakspan[i].style.display="none";
		}
		for (var i = 0; i < peakrow.length; i++) {
        peakrow[i].style.display="none";
		}
		break;
	/*if no selection made*/
	case "Select Use":
        priceBP = na;
		priceBO = na;
		priceFP = na;
		priceFO = na;
		priceGP = na;
		priceGO = na;
		for (var i = 0; i < peakspan.length; i++) {
        peakspan[i].style.display="none";
		}
		for (var i = 0; i < peakrow.length; i++) {
        peakrow[i].style.display="none";
		}
		disableBtn();
	}
	
document.getElementById('ClassB').innerHTML = getSelectedText('Use');
document.getElementById('ClassF').innerHTML = getSelectedText('Use');
document.getElementById('ClassG').innerHTML = getSelectedText('Use');

document.getElementById('PriceBP').innerHTML = priceBP;
document.getElementById('PriceBO').innerHTML = priceBO;

document.getElementById('PriceFP').innerHTML = priceFP;
document.getElementById('PriceFO').innerHTML = priceFO;

document.getElementById('PriceGP').innerHTML = priceGP;
document.getElementById('PriceGO').innerHTML = priceGO;
	}
	
	
function enableBtn() {
	
	exploreBtns = document.getElementsByClassName("btnExploreStudio");
	
		for (var i = 0; i < exploreBtns.length; i++) {
        exploreBtns[i].classList.add('active');
		exploreBtns[i].classList.remove('disabled');
		}
		
}

function disableBtn() {
	
	exploreBtns = document.getElementsByClassName("btnExploreStudio");
	
		for (var i = 0; i < exploreBtns.length; i++) {
        exploreBtns[i].classList.add('disabled');
		exploreBtns[i].classList.remove('active');
		}
		
}
/*from here https://stackoverflow.com/questions/610336/retrieving-the-text-of-the-selected-option-in-select-element
want the text not the value of the select option */
function getSelectedText(elementId) {
    var elt = document.getElementById(elementId);

    if (elt.selectedIndex == -1)
        return null;

    return elt.options[elt.selectedIndex].text;
}		
