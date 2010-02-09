// ==UserScript==
// @name           Hangar Summary
// @namespace      Hangar Summary by Arketypos
// @description    Adds Hangar Summary to Empire-->Fleets page
// @include        http://alpha.astroempires.com/empire.aspx?view=fleets
// ==/UserScript==

var hangar_space_no_cap = 0
var hangar_space_cap = 0
var hangar_space_used = 0

var unit = []
var unit_hanger = []

// FT = 2
// BO = 3
// HB = 4
// IB = 5
// CV = 6
// RC = 7
// DE = 8
// FR = 9
// IF = 10
// SS = 11
// OS = 12
// CR = 13
// CA = 14
// HC = 15
// BS = 16
// FC = 17
// DN = 18
// TI = 19
// LE = 20
// DS = 21


unit_hanger["FT"] = -1
unit_hanger["BO"] = -1
unit_hanger["HB"] = -2
unit_hanger["IB"] = -2
unit_hanger["FR"] = 4
unit_hanger["IF"] = 4
unit_hanger["CR"] = 4
unit_hanger["CA"] = 60
unit_hanger["HC"] = 8
unit_hanger["BS"] = 40
unit_hanger["FC"] = 400
unit_hanger["DN"] = 200
unit_hanger["TI"] = 1000
unit_hanger["LE"] = 4000
unit_hanger["DS"] = 10000

// unit_hanger["Fighters"] = -1
// unit_hanger["Bombers"] = -1
// unit_hanger["Heavy Bombers"] = -2
// unit_hanger["Ion Bombers"] = -2
// unit_hanger["Frigate"] = 4
// unit_hanger["Ion Frigate"] = 4
// unit_hanger["Cruiser"] = 4
// unit_hanger["Carrier"] = 60
// unit_hanger["Heavy Cruiser"] = 8
// unit_hanger["Battleship"] = 40
// unit_hanger["Fleet Carrier"] = 400
// unit_hanger["Dreadnought"] = 200
// unit_hanger["Titan"] = 1000
// unit_hanger["Leviathan"] = 4000
// unit_hanger["Death Star"] = 10000




collect_data();
print_data();


function collect_data() {
  var t = [];
  var regex = /[0-9]+/;
  table = document.getElementById('empire_fleets').rows[1].cells[0].getElementsByTagName('table');
  row = table[0].rows


  for (j=2; j < row[0].cells.length - 1; j++) {
    // unit_type = String(row[0].cells[i].innerHTML)
    // t[unit_type] = 0;
    t[j] = 0;
  }
  for (j = 2; j < row[0].cells.length - 1; j++) {
    unit[String(row[0].cells[j].innerHTML)] = 0
  }
  
  alert(unit);
  for (i=1; i < row.length; i++) {
    for (j=2; j < row[0].cells.length - 1; j++) {
      value = regex.exec(row[i].cells[j].innerHTML);
      if (value != null)
      t[j] += Number(value);
    }
  } 

  calculate_hangar_space(t);
}

function calculate_hangar_space(unit) {
  
  FT = 2
  BO = 3
  HB = 4
  IB = 5
  CV = 6
  RC = 7
  DE = 8
  FR = 9
  IF = 10
  SS = 11
  OS = 12
  CR = 13
  CA = 14
  HC = 15
  BS = 16
  FC = 17
  DN = 18
  TI = 19
  LE = 20
  DS = 21

  hangar_space_no_cap = unit[FR]*4 + unit[IF]*4 + unit[CR]*4 + unit[CA]*60 + unit[HC]*8 + unit[BS]*40 + unit[FC]*400
  hangar_space_cap = hangar_space_no_cap + unit[DN]*200 + unit[TI]*1000 + unit[LE]*4000 + unit[DS]*10000
  hangar_space_used = unit[FT] + unit[BO] + unit[HB]*2 + unit[IB]*2
}


function makeDiv(id, message) {
  var div = document.createElement("div");
  div.id = id;
  div.setAttribute("align","center");
  div.innerHTML = message;
  document.body.appendChild(div);
}

function print_data() {

  makeDiv("hangar_space_used", "Hangar Space Used: " + hangar_space_used + "<br /> <br />");

  makeDiv("hangar_space_no_cap", "Total Hangar Capacity (No Capitals): " + hangar_space_no_cap)
  makeDiv("empty_space_no_cap", "Remaining Hangar Capacity (No Capitals): " + (hangar_space_no_cap - hangar_space_used) + "<br /> <br />");

  makeDiv("hangar_space_cap", "Total Hangar Capacity (With Capitals): " + hangar_space_cap)
  makeDiv("empty_space_no_cap", "Remaining Hangar Capacity (With Capitals): " + (hangar_space_cap - hangar_space_used));
}