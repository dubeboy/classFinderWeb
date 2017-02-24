require 'time'
class VenueFinderController < ApplicationController

  def index
    d = Time.at(Time.now)
    day = d.wday
    # day = 5
    #  day = 3
    time = params['time'].nil? ? d.strftime("%H%M") : params['time'].delete!(":")

    # g = get_open_venues(@venue_hashes, time, day)
    # unless g.nil?
    #   @open_venues = g.uniq {|s| s[0]}  #Todo: why does it return duplicates
    # end

    if day == 6 or day == 0
      @open_venues = []
    else
      @open_venues = get_free_venue(time.to_i, day)
    end
  end

  private

  def exists(string, array)
    array.each_with_index do |element,index|
      if string.strip == element.strip
        return true
      end
    end
    false
  end

  @@sorted_array = [["A LES G01", "C1", "C2", "C3", "C4", "H1", "H2", " H3", " H4", "I1", "I2", " I3", " I4", "J1", " J2", " J3", " J4", "N1", " N2", " S1", " S2", "N3", " N4", "O3", " O4", "Q1", " Q2", "Q3", " Q4", "R3", " R4"],
                   ["A LES G02", "H3", " H4", "I1", " I2", " I3", " I4", "J1", " J2", " J3", " J4", "K1", " K2", "K3", " K4", "L1", " L2", "N1", " N2", " S1", " S2", "O1", " O2", "Q1", " Q2", " C1", " C2", "Z1", " Z2", " Z3", " Z4"],
                   ["A RING 522", "I1", " I2", " I3", " I4"],
                   ["A RING 610", "M1", " M2", " M3", " M4", "P26"],
                   ["B LES 100", "C1", " C2", " L1", " L2", " R1", " R2", "I1", " I2", "I3", " I4", " J1", "M1", " M2", " M3", " M4", "O1", " O2", " S1", " S2", "P29", "P30", "Q1", " Q2", "T3", " T4", "Z1", " Z2", " Z3", " Z4"],
                   ["B LES 101", "L1", " L2", "N1", " N2", "Q1", " M3", " Q3", "T1", "T3", " T4", "Z3", " Z4"],
                   ["B LES 103", "I1", " I2", "K3", " K4", "P6", "P7", "Q4", " O4"], ["B LES 104", "C3", " C4", "H2", " R3", "I1", " I2", "M1", " M2", " M3", " M4", "Z1", " Q3", " Q4", "Z3", " Z4"], ["B RING 301", "O1"], ["B RING 709", "K2", " R1"],
                   ["B RING 712", "N1", "N2", " N3", " N4", "Q1", "Q2", " Q3", " Q4", "S2", " S3", " S4"],
                   ["B RING 726", "I2", "J2", "O1", "R3", "S1", "Z1"], ["B1 LAB 204", "I1", " I2", "M1", " M2", " M3", " M4", "P1", "P2", "P3", "P4", "P8", "P9"],
                   ["B2 LAB 117 FEBE COMP LAB", "P1", "P2", "P3", "P4", "P6", "P7", "P8", "P9"],
                   ["B2 LAB 119 FEBE COMP LAB", "G1", " N1", " N2", "M1", " M3", " M4", "O1", " Q4", " O4", "O3", "P17", "P18", "P19", "P20", "P21", "P22", "P23", "P24", "P29", "P30", "P31", "P32"],
                   ["B2 LAB 12", "O1", " O2", " O3", " O4", "P22", "P23", "P24"],
                   ["B2 LAB 219 FEBE COMP LAB", "M2", " M3", " M4", "P6", "P7", "P8", "P9", "Q3", " Q4"],
                   ["B3 LAB 11", "M1", " M2", " L1", " L2", "O1", " O2"],
                   ["C LES 101", "G4", "H1", " H2", " J1", " J2", "I1", "I3", " I4", "J4", " C3", "M1", " M2", "N1", " N2", "O1", " O2", " T1", " T2", "T3", " T4", "Z1", "Z2"],
                   ["C LES 102", "C1", " C2", "K1", " K2", " R2", "K3", " K4", " Q4", " J3", "O1", " O2", " O3", " O4", "P13", "P14", "P30", "P31", "P32", " S3", "Q1", " Q2"],
                   ["C LES 103", "H1", " H2", "H3", " H4", "I1", " I2", " I3", "J1", "J2", "J3", " J4", "L1", " L2", "M1", " M2", "P25", "P26", "T1", " T2", " R1", " R2", "Z1", "Z2"],
                   ["C LES 201", "C1", " C2", "G1", " G2", " Z3", " Z4", "I1", " I2", "Q1", " Q2", " Q3", " Q4", "R3", " R4"],
                   ["C LES 202", "C1", " C2", "I1", " I2", " K3", " K4", "K1", " K2", "N1", " N2", "O1", " O2", "S1", " S2", "Z1", " Z2", " Z3", " Z4"],
                   ["C LES 203", "C1", " C2", "C3", " C4", "I1", " I2", " R1", " R2", "M3", "P13", "P14", "P15", "P16", "Q1", " Q2", "Q4"],
                   ["C LES 204", "H1", " H2", " S3", " S4", "H3", " H4", "M3", " M4", "P29", "P30", "T1", " T2", "Z1", " Z2", " Z3", " Z4"],
                   ["C LES 301", "H1", "I2", "I3", "J1", "M1", " M2", " M3", "M4", "N3", "O1", "O2", "O4", "Q1", "Q2", "R1", " R2"],
                   ["C LES 302", "I2", "J1", "M3", "N1", " N2", "O1", "O2", " O4", "Q2", "T4"],
                   ["C LES 304", "H1", "I2", " M3", " M4", "J3", " J4", " C3", " C4", "K1", " K2", " C1", " C2", "L4", " L1", "M1", " M2", "P17", "P18", "R3", " R4", "T1"],
                   ["C LES 305", "H1", "I1", "I2", "I3", "J1", "N3", "O1", " O2", " R1", " R2", "Q2", "T3", "Z1", "Z2"],
                   ["C LES 306", "H4", "I1", "I2", "I3", "K1", "L2", "M1", "M2", "M3", "O2", "Q2", "R1", "R2", "T1", "Z1", " Z2", " Z3", " Z4"],
                   ["C LES 307", "J1", "J3", " J4", "O1", " O2", " C1", " C2", "Q4", "R1", " R2", "Z3", " Z4"],
                   ["C LES 308", "H1", "H2", "H4", "I1", "I3", " I4", "K1", " K2", "M3", "M4", " T1", "Q2", "S2"],
                   ["C LES 309", "J3", " J4", "K1", " K2", "N1", " N2", "O4", "P19", "P20", "Q3", "Z2", " G4", " Z3"],
                   ["C LES 310", "C3", " C4", "G1", "H3", " H4", "I3", "K1", " K2", "L2", " R1", "M1", "O1"],
                   ["C LES 401", "C1", " C2", " Q3", " Q4", "K1", " K2", " K3", " K4", "M1", " M2", "O1", " O2", " O3", " O4", "P6", "P7", "Q1", " Q2", "R3", " R4"],
                   ["C LES 402", "G1", "I1", "J1", "J2", "J3", "J4", "L3", " L2", "N1", " N2", " N3", " N4", "P13", "P14", "Q3", " Q4", "R1", "Z3"],
                   ["C LES 403", "H1", "H3", " H4", "I1", "J1", "J2", "J3", " J4", "K1", "L3", " L2", "L4", " L1", "O1", "O4", "Q2", "Q3", "R1", "R2", "Z1"],
                   ["C LES 404", "I1", "J1", "J2", "K1", "M3", "O1", " O2", "P12", "P13"], ["C RING 303 COMPUTER LAB", "P15", "P17", "P23"],
                   ["C RING 307 COMPUTER LAB", "P19", "P26"],
                   ["C RING 308", "P21", "P22"],
                   ["C1 LAB 215 LABORATORY", "K1", " K2", " K3", " K4", "L1", " L2", " L3", " L4", "M1", " M2", " Q1", " Q2", "O1", " O2", " N1", " N2", "P21", "P22", "P23", "P24", "P6", "P7", "P8", "Z1", " Z2", " Z3", " Z4"],
                   ["C1 LAB 221", "P13", "P14"],
                   ["C1 LAB 303", "P13", "P20"],
                   ["C1 LAB 304", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20", "Q1", " Q2", " G3", " G4"],
                   ["C1 LAB K001", "P1", "P2", "P3", "P4", " R3", "P17", "P18", "P19", "P20", " N3", "P25", "P26", "P27", "P28"],
                   ["C2 LAB 115 LABORATORY", "O1", " O2", " Z1", " Z2", "P1", "P2", "P3", "P4", " R3", "P17", "P18", "P19", "P20", " N3", "P25", "P26", "P27", "P28", " O3", "P29", "P30", "P31", "P32", " S3", "P6", "P7", "P8", "P9", " L3"],
                   ["C2 LAB 122 LABORATORY", "P15", "P16", "P17", "P18", "P19", "P20", " N3", " N4", "P22", "P23", "P24", "P25", "P26", "P27", "P28", " O3"],
                   ["C2 LAB 123 LABORATORY", "P23", "P24", "P25", "P26", "P27", "P28", " O3", " G3"],
                   ["D LAB BASEMENT ROOM K01", "H1", " H2", " J1", " J2", "J3", " J4", "K3", " K4", "L3", " L1", " L2", "N3", " N4", "O3", " G3", " O4", "P6", "P7", "Q1", " M3", " Q3"],
                   ["D LAB BASEMENT ROOM K02", "L1", " L2", " R1", " R2", "O1", " O2", " O4", "P12", "P13", "P14", "P15", "Q3", " Q4", "Z1", " Z2"],
                   ["D LAB BASEMENT ROOM K03", "H1", " H2", " R1", " R2", "L1", " L2", "N1", " N2", " I3", " I4", "P13", "P14", "T3", " T4"],
                   ["D LES 101", "I4", " O3", "J1", " J2", " J3", " J4", "L3", " L4", " L1", " L2", "Z1", " Z2", " Z3", " Z4"],
                   ["D LES 102", "J4", " C3", "L3", " L1", " L2", "O1", " O2", " T1", " T2", "P15", "P16", "Z1", " Z2"],
                   ["D LES 103", "H1", " H2", " J3", " J4", "L3", " L2", "L4", " L1", "N1", " N2", " N3", " N4", "O1", " O2", " O3", " O4", "P1", "P2", " P17", "P18", "P21", "P22", "P6", "P7", " P16", "Q3", " Q4", "T4"],
                   ["D LES 104", "J1", " J2", "N1", " N2", "S1", "T3"],
                   ["D LES 105", "H1", " H2", " H3", " H4", "J1", " J2", " J3", " J4", "L1", " L2", "O1", " O2", "WE 14", " WE 15"],
                   ["D LES 106", "H3", " H4", "I3", "Q2", " Q4", "T1", " T2", "Z2"], ["D LES 201", "P1", "P2", "P15", "P16", "P25", "P26", "R3", " R4", "Z3", " Z4", "J1", "J2"],
                   ["D LES 202", "J2", "S1", "T1", " T2", " T3", " T4"],
                   ["D LES 203", "H3", " H4", "J1", " J2", "P1", "P2", "Q3", " Q4", "S1", " S2"],
                   ["D LES 204", "L2", " R1", "T1", " T2", " T3", " T4"],
                   ["D LES 301", "I1", " I2", " I3", " I4", "P17", "P18", "Q1", " Q2", " L1", " L2", "S1", " S2", "T1", " T2", " T3", " T4"],
                   ["D LES 304", "K1", " K2", "P25", "P26", "Q1", " Q2"], ["D LES 305", "K1", " K2", "Q3", "Q4"],
                   ["D LES 306", "Q1", " Q2", "T1", " T2", "T3", " T4"],
                   ["D LES 307", "I1", " I2", "M3", "M4", "Q4", "S1", "S2"],
                   ["D LES 308", "C2", "H3", " H4", "I2", "I3", "K1", "K2", "K3", "T4"],
                   ["D LES 309", "I1", "J1", "K3", "L2", " R1", "M1", " M2", " M3", " M4", "T3"],
                   ["D LES 310", "G1", "J1", " J2", "K3", "M1", "O2", "T4"],
                   ["D LES 311", "G1", "H3", "K3", "M2", "Q1", "Q2", "S1", "T2", "T3", "T4"],
                   ["D LES 312", "G1", "H1", " H2", " H3", " H4", "I1", "K3", "N3", " N4", "O1", " O2", "Q3"],
                   ["D LES 403", "J1", "J2", "M1", " M2", "M3"],
                   ["D LES 404", "I4", "K3", "Q1", "Q2", "T1", "T2", "T3"],
                   ["D LES 405", "C1", " C2", "H1", "I1", " H4", "I2", "I4", "J1", "J2", "K2", "K3", "M2", " M3", " M4", "Q1", " Q2", " Q3", " Q4", "S1", "T2", "T3", "T4"],
                   ["D LES 406", "H1", "H2", "I1", "I2", "I4", "J1", "J2", "K1", "K3", "M1", " M2", "M4", "Q2", "S1", "S2", "T3"],
                   ["D LES 407", "I1", " I2", " T3", " T4", "M1", " M2", " M3", " M4"],
                   ["D LES 408", "H1", "H3", "I4", "K1", "K2", "K3", "R2", "T2", "T3", "Z1", " Z2", " M3", " M4"],
                   ["D LES 410", "H1", "I1", " I2", "K1", "K2", "K3", "M1", "M2", "O1", "Q1", "Q2", "T3", "T4"],
                   ["D LES 411", "I1", "M4", "T3", "T4"],
                   ["D1 LAB 108", "G1", " G2", " G3", " G4", "N1", " N2", " N3", " N4", "O1", " O2", "P17", "P18", "P25", "P26", "P8", "P9", "R1", " R2", "S1", " S2", "Z1", " Z2", "Z3", " Z4"], ["D1 LAB 401", "C1", "H3", "H4", "J1", "J3", " J4", "K3", " K4", "L2", "MO 14", " MO 15", "N1", " N2", "O1", "O4", "Q1", "Q3", "Q4", "T3", "T4", "Z3", "Z4"],
                   ["D1 LAB 402", "H2", "I1", " I2", "I3", " I4", "M1", " T3", "N2", "O1", "O2", "Q2", "Q3", "Q4", "S1", "S2", "T1", " T2", "T4"],
                   ["D1 LAB 403", "C1", "G2", "H1", "H3", "I3", "I4", "J1", " J2", "K1", "K3", "L1", "M3", "M4", "O1", "O2", "O4", "Q3", "Q4", "S1", "S2", "T3", "Z1", "Z4"],
                   ["D1 LAB 404", "H2", "J1", "J2", "K3", "O1", "O2", "S1", "T4", "Z4"],
                   ["D1 LAB 405", "C1", "G2", "H1", "I2", " R1", "J1", "K1", "K3", "L1", "L2", "M3", "M4", "O2", "S1", "T2", "Z4"],
                   ["D1 LAB 406", "G1", "H2", "K1", "L2", "M1", "M4", " I3", "N2", "O2", "Q1", "Q2", "Q3", "R2", "S1", "T1", "T2", "T4", "Z4"],
                   ["D1 LAB 407", "G1", "H1", "K1", "M1", "M3", "M4", " I3", "N1", "N2", "O2", "Q4", "S2", "T1", " T2"],
                   ["D1 LAB 408", "G1", "H4", "I3", "J1", "J2", "J3", " J4", "L1", "M1", "N2", "O1", "Q2", "Q3", "Q4", "R1", "R2", "Z3", " Z4"],
                   ["D1 LAB 409", "H3", "J1", " J2", "J3", " J4", "L1", "M1", "M2", "M4", "O1", "O2", "Q1", " Q2", "T3", "T4", "Z3", "Z4"],
                   ["D1 LAB 410", "G1", "H4", "I3", "J4", "K3", " L2", "K4", "M1", "N2", " H3", "O1", "O2", "Q2", "Q3", " Q4", "S2", "T2", "Z1", "Z2"],
                   ["D1 LAB 411", "G1", "G2", "H2", "H4", "I2", " R1", "I3", "J1", "K1", " K2", "K3", " L2", "K4", "M3", "M4", "N2", " H3", "O1", "O2", "Q3", "Q4", "R2", "S1", "S2"],
                   ["D1 LAB 412", "G1", "H1", "H2", "H3", "H4", "J3", " J4", "K4", "L1", "M1", "M2", "M3", "N2", "O1", "O2", "Q1", "Q2", "Q3", "Q4", "T3", "T4", "Z1", " Z2"],
                   ["D1 LAB 413", "G1", "H1", "H3", "H4", "L2", "M1", "M4", "O1", "O2", "Q1", "Q3", "Q4", "T4"],
                   ["D1 LAB 414", "G2", "J3", " J4", "K2", "M2", "M3", "N2", "Q2", "Q3", "Q4", "R1", "R2"],
                   ["D1 LAB 415", "G1", "G2", "K2", "L2", "M1", " T3", "N1", "N2", "O1", "Q1", "Q2", "Q4", "T4"],
                   ["D1 LAB 416", "H1", "H2", "I1", "J1", "J3", " J4", "K2", "M1", "M4", "N1", "O1", "O4", "Q2", "R1", " R2", "Z2"],
                   ["D1 LAB K08", "G1", " Z3", " Z4", "I1", " I2", "I3", " I4", "K3", " K4", "M1", " M2", " M3", " M4", "O1", " S1", " S2", "P15", "P16", "T1", " T2", " T3", " T4", "TH 14", " TH 15", " TH 16", " TH 17", "Z1", " Z2"],
                   ["D1 LAB K09", "P12", "P13", "P14", "P15", "R1", " R2"],
                   ["D1 LAB K10", "H1", " H2", " Q1", " Q2", "L1", " L2", "O1", " O2", " O4", "P25", "P26"],
                   ["D1 LAB K11", "K3", " K4", "L2", " P21", "O4", "P12", "P13", "P14", "P15", "T1", " T2"],
                   ["D1 LAB K12", "M1", " M2", "O1", " O2", " Q1", " Q2", "O3", " O4", "P1", "P2", "P3", "P4", "P17", "P18", "P6", "P7", "T1"],
                   ["D2 LAB 115 LABORATORY", "O1", " O2", " O3", "P13", "P14", "P15", "P16", "P17", "P18", "P19", "P20", "P25", "P26", "P27", "P28", "Z1", " Z2", " P1", "P2", "P3", "P4", "P29", "P30", "P31", "P32"],
                   ["D2 LAB 116 LABORATORY", "P17", "P18", "P19", "P20", "P21", "P22", "P23", "P24"],
                   ["D2 LAB 121 LABORATORY", "P29", "P30", "P31", "P32", " S3", " S4", "S1", " S2"],
                   ["D2 LAB 333 LABORATORY", "M2", " Q1", " Q2", " P6", "P7", "P8", "P9", "P23", "P24", "P25", "P26", "P27", "P28", " O3", " G3"],
                   ["D2 LAB ROOM 122", "L1", " L2", "M1", " M2", " M3", " M4", "O2", " T3", " T4", "Q1", " Q2", " Q3", " Q4"],
                   ["D3 LAB 120 LABORATORY", "M3", " M4", " H4"],
                   ["D3 LAB 240 LABORATORY", "O1", " O2", "P1", "P2", "P3", "P4", "P15", "P16", "P17", "P18", "P19", "P20"],
                   ["D3 LAB 330 LABORATORY", "N1", " N2", " N3", " N4", "P25", "P26", "P27", "P28", "P29", "P30", "P31", "P32"],
                   ["E LES 100", "J1", " J2", "J3", " J4", " C3", " C4", "K1", " K2", "L1", " L2", "M3", " M4", "N1", " N2", "P15", "P16", "T1", " T2", " T3", "T4"],
                   ["E LES 200", "C1", " C2", "H1", " H2", "I3", "I4", "K1", " K2", "L3", " L4", "Z1", " Z2", " Z4"],
                   ["E LES 201 COMPUTER LABS", "P25", "P26"],
                   ["E LES 202 COMPUTER LAB", "P7", "P8", "P9", "Q1", " Q2"],
                   ["E RING COMPUTER LAB 203", "P26", "P27", "P28", " O3", "P7", "P8", "P9"],
                   ["E RING COMPUTER LAB 204", "P7", "P8", "P9"],
                   ["E RING COMPUTER LAB 205", "P26", "P27", "P28", " O3", "P29", "P30", "P31", "P32", "P7", "P8", "P9", "S3", " S4"],
                   ["E RING COMPUTER LAB 206", "P29", "P30", "P31", "P32", "P7", "P8", "P9", "S3", " S4"],
                   ["E RING COMPUTER LAB 207", "P26", "P27", "P28", " O3", "P29", "P30", "P31", "P32", "P7", "P8", "P9", "S3", " S4", "WE 17"]]



# require 'csv'


  monday_apk = [['NULL'], ['NULL'], ['NULL'], ['O1'], ['O2'], ['Z1'],
                ['Z2'], ['K1', 'P1'], ['K2', 'P2'], ['H1', 'P3'], ['H2', 'P4'], ['R3'], ['R4']]


  tuesday_apk = [['G1'], ['N1'], ['N2'], ['M1'],
                 ['M2'], ['Q1'], ['Q2'], ['I1', 'P6'], ['I2', 'P7'],
                 ['K3', 'P8'], ['K4', 'P9'], ['L3'], ['L4']]

  wednesday_apk = [['G2'], ['M3'], ['M4', 'P12'], ['T1', 'P13'],
                   ['T2', 'P14'], ['S1', 'P15'], ['S2', 'P16'],
                   ['J1', 'P17'], ['J2', 'P18'], ['C1', 'P19'], ['C2', 'P20'], ['N3'], ['N4']]

  thursday_apk = [['L1'], ['L2'], ['R1', 'P21'], ['R2', 'P22'],
                  ['T3', 'P23'], ['T4', 'P24'], ['H3', 'P25'],
                  ['H4', 'P26'], ['I3', 'P27'], ['I4', 'P28'], ['O3'], ['G3'], ['G4']]

  friday_apk = [['Z3'], ['Z4'], ['Q3'], ['Q4'], ['O4'],
                ['NULL'], ['NULL'], ['J3', 'P29'],
                ['J4', 'P30'], ['C3', 'P31'],['C4', 'P32'], ['S3'], ['S4']]

  @all_codes = [monday_apk, tuesday_apk, wednesday_apk, thursday_apk, friday_apk]
# printing out the free venues
# convert_time_to_code()

  def convert_time_to_do_mon(time)
    puts 'In here'
    if time >= 1000 and time <= 1045
      return ['O1']
    elsif time > 1045 and time <= 1135
      return ['O2']
    elsif time > 1135 and time <= 1225 # monday starts here
      return ['Z1']
    elsif time > 1025 and time <= 1315
      return ['Z2']
    elsif time > 1315 and time <= 1405
      return ['K1',  'P1']
    elsif time > 1405 and time <= 1455
      return ['K2' ,  'P2']
    elsif time > 1455 and time <= 1545
      return ['H1' , 'P3']
    elsif time > 1545 and time <= 1635
      return ['H2' , 'P4']
    elsif time > 1635 and time <= 1725
      return ['R3']
    elsif time > 1725 and time <= 1815
      return ['R4']
    else
      nil
    end
  end

  def convert_time_to_code(time, day)
    if day == 1
      convert_time_to_do_mon(time)
    else #this is when day os not 2
      if time >= 800 and time <= 845
        if day == 2
          return ['G1']
        end
        if day == 3
          return ['G2']
        end
        if day == 4
          return ['L1']
        end
        if day == 5
          return ['Z3']
        end

      elsif time > 845 and time <= 935
        if day == 2
          return ['N1']
        end
        if day == 3
          return ['M3']
        end
        if day == 4
          return ['L2']
        end
        if day == 5
          return ['Z4']
        end
      elsif time > 935 and time <= 1025 # monday starts here
        if day == 2 # tues
          return ['N2']
        end
        if day == 3 # wed
          return ['M4', 'P12']
        end
        if day == 4 # thurs
          return ['R1',  'p21']
        end
        if day == 5 # fri
          return ['Q3']
        end
      elsif time > 1025 and time <= 1115
        if day == 2 # tues
          return ['M1']
        end
        if day == 3 # wed
          return ['T1', 'P13']
        end
        if day == 4 # thurs
          return ['R2 P22']
        end
        if day == 5 # fri
          return ['Q4']
        end
      elsif time > 1115 and time <= 1205
        if day == 2 # tues
          return ['M2']
        end
        if day == 3 # wed
          return ['T2', 'P14']
        end
        if day == 4 # thurs
          return ['T3', 'P23']
        end
        if day == 5 # fri
          return ['O4']
        end
      elsif time > 1205 and time <= 1255
        if day == 2 # tues
          return ['Q1']
        end
        if day == 3 # wed
          return ['S1', 'P15']
        end
        if day == 4 # thurs
          return ['T4', 'P24']
        end
        if day == 5 # fri
          return [] #culture day
        end
      elsif time > 1255 and time <= 1345
        if day == 2 # tues
          return ['Q2']
        end
        if day == 3 # wed
          return ['S2', 'P16']
        end
        if day == 4 # thurs
          return ['H3', 'P25']
        end
        if day == 5 # fri
          return []  #culture day
        end
      elsif time > 1345 and time <= 1435
        if day == 2 # tues
          return ['I1', 'P6']
        end
        if day == 3 # wed
          return ['J1' ,'P17']
        end
        if day == 4 # thurs
          return ['H4', 'P26']
        end
        if day == 5 # fri
          return ['J3', 'P29']
        end
      elsif time > 1435 and time <= 1525

        if day == 2 # tues
          return ['L2', 'P7']
        end
        if day == 3 # wed
          return ['J2', 'P18']
        end
        if day == 4 # thurs
          return ['I3', 'P27']
        end
        if day == 5 # fri
          return ['J4', 'P30']
        end
      elsif time > 1525 and time <= 1615

        if day == 2 # tues
          return ['K3', 'P8']
        end
        if day == 3 # wed
          return ['C1', 'P19']
        end
        if day == 4 # thurs
          return ['I4' ,'P28']
        end
        if day == 5 # fri
          return ['C3', 'P31']
        end
      elsif time > 1615 and time <= 1705

        if day == 2 # tues
          return ['K4', 'P9']
        end
        if day == 3 # wed
          return ['C2' ,  'P20']
        end
        if day == 4 # thurs
          return ['O3']
        end
        if day == 5 # fri
          return ['C4',  'P32']
        end
      elsif time > 1705 and time <= 1755

        if day == 2 # tues
          return ['L3']
        end
        if day == 3 # wed
          return ['N3']
        end
        if day == 4 # thurs
          return ['G3']
        end
        if day == 5 # fri
          return ['S3']
        end
      elsif time > 1755 and time <= 1845  # else its part time man
        if day == 2 # tues
          return ['L4']
        end
        if day == 3 # wed
          return ['N4']
        end
        if day == 4 # thurs
          return ['G4']
        end
        if day == 5 # fri
          return ['S4']
        end
      else
        []
      end
    end
  end

  def gen_venue_array(time, day)
    code = convert_time_to_code(time, day) #code is an array eg ['C1']
    v = Hash.new #new hash
    temp = Array.new
    code.each do |c|
      temp = []
      @@sorted_array.each_with_index do |venue, i|
        if exists(c, venue)
          temp.push(venue[0])
        end
      end
      v[c] = temp
    end
    v
  end

  def gen_venues_for_code
    temp = []
    for day in 1..5
      if day == 1
        for time in (1000..1845).step(50)
          my_hash = gen_venue_array(time, day) # {}
          temp.push(my_hash)
        end
      else #its not monday
        for time in (800..1845).step(50)
          my_hash = gen_venue_array(time, day) # {}
          temp.push(my_hash)
        end
      end
    end
    return temp
  end

# puts '----------------result'
# puts gen_venues_for_code.to_s
# puts '----------------result'
# puts 'The end'


  @@op = [{"O1"=>["A LES G02", "B LES 100", "B RING 301", "B RING 726", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 12", "B3 LAB 11", "C LES 101", "C LES 102", "C LES 202", "C LES 301", "C LES 302", "C LES 305", "C LES 307", "C LES 310", "C LES 401", "C LES 403", "C LES 404", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K02", "D LES 102", "D LES 103", "D LES 105", "D LES 312", "D LES 410", "D1 LAB 108", "D1 LAB 401", "D1 LAB 402", "D1 LAB 403", "D1 LAB 404", "D1 LAB 408", "D1 LAB 409", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D1 LAB 415", "D1 LAB 416", "D1 LAB K08", "D1 LAB K10", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"O2"=>["A LES G02", "B LES 100", "B2 LAB 12", "B3 LAB 11", "C LES 101", "C LES 102", "C LES 202", "C LES 301", "C LES 302", "C LES 305", "C LES 306", "C LES 307", "C LES 401", "C LES 404", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K02", "D LES 102", "D LES 103", "D LES 105", "D LES 310", "D LES 312", "D1 LAB 108", "D1 LAB 402", "D1 LAB 403", "D1 LAB 404", "D1 LAB 405", "D1 LAB 406", "D1 LAB 407", "D1 LAB 409", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D1 LAB K10", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D2 LAB ROOM 122", "D3 LAB 240 LABORATORY"]}, {"O2"=>["A LES G02", "B LES 100", "B2 LAB 12", "B3 LAB 11", "C LES 101", "C LES 102", "C LES 202", "C LES 301", "C LES 302", "C LES 305", "C LES 306", "C LES 307", "C LES 401", "C LES 404", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K02", "D LES 102", "D LES 103", "D LES 105", "D LES 310", "D LES 312", "D1 LAB 108", "D1 LAB 402", "D1 LAB 403", "D1 LAB 404", "D1 LAB 405", "D1 LAB 406", "D1 LAB 407", "D1 LAB 409", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D1 LAB K10", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D2 LAB ROOM 122", "D3 LAB 240 LABORATORY"]}, {"Z1"=>["A LES G02", "B LES 100", "B LES 104", "B RING 726", "C LES 101", "C LES 103", "C LES 202", "C LES 204", "C LES 305", "C LES 306", "C LES 403", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K02", "D LES 101", "D LES 102", "D LES 408", "D1 LAB 108", "D1 LAB 403", "D1 LAB 410", "D1 LAB 412", "D1 LAB K08", "D2 LAB 115 LABORATORY", "E LES 200"]}, {"Z1"=>["A LES G02", "B LES 100", "B LES 104", "B RING 726", "C LES 101", "C LES 103", "C LES 202", "C LES 204", "C LES 305", "C LES 306", "C LES 403", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K02", "D LES 101", "D LES 102", "D LES 408", "D1 LAB 108", "D1 LAB 403", "D1 LAB 410", "D1 LAB 412", "D1 LAB K08", "D2 LAB 115 LABORATORY", "E LES 200"]}, {"Z2"=>["A LES G02", "B LES 100", "C LES 101", "C LES 103", "C LES 202", "C LES 204", "C LES 305", "C LES 306", "C LES 309", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K02", "D LES 101", "D LES 102", "D LES 106", "D LES 408", "D1 LAB 108", "D1 LAB 410", "D1 LAB 412", "D1 LAB 416", "D1 LAB K08", "D2 LAB 115 LABORATORY", "E LES 200"]}, {"Z2"=>["A LES G02", "B LES 100", "C LES 101", "C LES 103", "C LES 202", "C LES 204", "C LES 305", "C LES 306", "C LES 309", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K02", "D LES 101", "D LES 102", "D LES 106", "D LES 408", "D1 LAB 108", "D1 LAB 410", "D1 LAB 412", "D1 LAB 416", "D1 LAB K08", "D2 LAB 115 LABORATORY", "E LES 200"]}, {"K1"=>["A LES G02", "C LES 102", "C LES 202", "C LES 304", "C LES 306", "C LES 308", "C LES 309", "C LES 310", "C LES 401", "C LES 403", "C LES 404", "C1 LAB 215 LABORATORY", "D LES 304", "D LES 305", "D LES 308", "D LES 406", "D LES 408", "D LES 410", "D1 LAB 403", "D1 LAB 405", "D1 LAB 406", "D1 LAB 407", "D1 LAB 411", "E LES 100", "E LES 200"], "P1"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "C1 LAB K001", "C2 LAB 115 LABORATORY", "D LES 103", "D LES 201", "D LES 203", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"K1"=>["A LES G02", "C LES 102", "C LES 202", "C LES 304", "C LES 306", "C LES 308", "C LES 309", "C LES 310", "C LES 401", "C LES 403", "C LES 404", "C1 LAB 215 LABORATORY", "D LES 304", "D LES 305", "D LES 308", "D LES 406", "D LES 408", "D LES 410", "D1 LAB 403", "D1 LAB 405", "D1 LAB 406", "D1 LAB 407", "D1 LAB 411", "E LES 100", "E LES 200"], "P1"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "C1 LAB K001", "C2 LAB 115 LABORATORY", "D LES 103", "D LES 201", "D LES 203", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"K2"=>["A LES G02", "B RING 709", "C LES 102", "C LES 202", "C LES 304", "C LES 308", "C LES 309", "C LES 310", "C LES 401", "C1 LAB 215 LABORATORY", "D LES 304", "D LES 305", "D LES 308", "D LES 405", "D LES 408", "D LES 410", "D1 LAB 411", "D1 LAB 414", "D1 LAB 415", "D1 LAB 416", "E LES 100", "E LES 200"], "P2"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "C1 LAB K001", "C2 LAB 115 LABORATORY", "D LES 103", "D LES 201", "D LES 203", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"H1"=>["A LES G01", "C LES 101", "C LES 103", "C LES 204", "C LES 301", "C LES 304", "C LES 305", "C LES 308", "C LES 403", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K03", "D LES 103", "D LES 105", "D LES 312", "D LES 405", "D LES 406", "D LES 408", "D LES 410", "D1 LAB 403", "D1 LAB 405", "D1 LAB 407", "D1 LAB 412", "D1 LAB 413", "D1 LAB 416", "D1 LAB K10", "E LES 200"], "P3"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "C1 LAB K001", "C2 LAB 115 LABORATORY", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"H2"=>["A LES G01", "B LES 104", "C LES 101", "C LES 103", "C LES 204", "C LES 308", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K03", "D LES 103", "D LES 105", "D LES 312", "D LES 406", "D1 LAB 402", "D1 LAB 404", "D1 LAB 406", "D1 LAB 411", "D1 LAB 412", "D1 LAB 416", "D1 LAB K10", "E LES 200"], "P4"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "C1 LAB K001", "C2 LAB 115 LABORATORY", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"H2"=>["A LES G01", "B LES 104", "C LES 101", "C LES 103", "C LES 204", "C LES 308", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K03", "D LES 103", "D LES 105", "D LES 312", "D LES 406", "D1 LAB 402", "D1 LAB 404", "D1 LAB 406", "D1 LAB 411", "D1 LAB 412", "D1 LAB 416", "D1 LAB K10", "E LES 200"], "P4"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "C1 LAB K001", "C2 LAB 115 LABORATORY", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"R3"=>["A LES G01", "B LES 104", "B RING 726", "C LES 201", "C LES 304", "C LES 401", "C1 LAB K001", "C2 LAB 115 LABORATORY", "D LES 201"]}, {"R3"=>["A LES G01", "B LES 104", "B RING 726", "C LES 201", "C LES 304", "C LES 401", "C1 LAB K001", "C2 LAB 115 LABORATORY", "D LES 201"]}, {"R4"=>["A LES G01", "C LES 201", "C LES 304", "C LES 401", "D LES 201"]}, {"R4"=>["A LES G01", "C LES 201", "C LES 304", "C LES 401", "D LES 201"]}, {"G1"=>["B2 LAB 119 FEBE COMP LAB", "C LES 201", "C LES 310", "C LES 402", "D LES 310", "D LES 311", "D LES 312", "D1 LAB 108", "D1 LAB 406", "D1 LAB 407", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D1 LAB 415", "D1 LAB K08"]}, {"N1"=>["A LES G01", "A LES G02", "B LES 101", "B RING 712", "B2 LAB 119 FEBE COMP LAB", "C LES 101", "C LES 202", "C LES 302", "C LES 309", "C LES 402", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K03", "D LES 103", "D LES 104", "D1 LAB 108", "D1 LAB 401", "D1 LAB 407", "D1 LAB 415", "D1 LAB 416", "D3 LAB 330 LABORATORY", "E LES 100"]}, {"N1"=>["A LES G01", "A LES G02", "B LES 101", "B RING 712", "B2 LAB 119 FEBE COMP LAB", "C LES 101", "C LES 202", "C LES 302", "C LES 309", "C LES 402", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K03", "D LES 103", "D LES 104", "D1 LAB 108", "D1 LAB 401", "D1 LAB 407", "D1 LAB 415", "D1 LAB 416", "D3 LAB 330 LABORATORY", "E LES 100"]}, {"N2"=>["A LES G01", "A LES G02", "B LES 101", "B RING 712", "B2 LAB 119 FEBE COMP LAB", "C LES 101", "C LES 202", "C LES 302", "C LES 309", "C LES 402", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K03", "D LES 103", "D LES 104", "D1 LAB 108", "D1 LAB 401", "D1 LAB 402", "D1 LAB 406", "D1 LAB 407", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 414", "D1 LAB 415", "D3 LAB 330 LABORATORY", "E LES 100"]}, {"N2"=>["A LES G01", "A LES G02", "B LES 101", "B RING 712", "B2 LAB 119 FEBE COMP LAB", "C LES 101", "C LES 202", "C LES 302", "C LES 309", "C LES 402", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K03", "D LES 103", "D LES 104", "D1 LAB 108", "D1 LAB 401", "D1 LAB 402", "D1 LAB 406", "D1 LAB 407", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 414", "D1 LAB 415", "D3 LAB 330 LABORATORY", "E LES 100"]}, {"M1"=>["A RING 610", "B LES 100", "B LES 104", "B1 LAB 204", "B2 LAB 119 FEBE COMP LAB", "B3 LAB 11", "C LES 101", "C LES 103", "C LES 301", "C LES 304", "C LES 306", "C LES 310", "C LES 401", "C1 LAB 215 LABORATORY", "D LES 309", "D LES 310", "D LES 403", "D LES 406", "D LES 407", "D LES 410", "D1 LAB 402", "D1 LAB 406", "D1 LAB 407", "D1 LAB 408", "D1 LAB 409", "D1 LAB 410", "D1 LAB 412", "D1 LAB 413", "D1 LAB 415", "D1 LAB 416", "D1 LAB K08", "D1 LAB K12", "D2 LAB ROOM 122"]}, {"M1"=>["A RING 610", "B LES 100", "B LES 104", "B1 LAB 204", "B2 LAB 119 FEBE COMP LAB", "B3 LAB 11", "C LES 101", "C LES 103", "C LES 301", "C LES 304", "C LES 306", "C LES 310", "C LES 401", "C1 LAB 215 LABORATORY", "D LES 309", "D LES 310", "D LES 403", "D LES 406", "D LES 407", "D LES 410", "D1 LAB 402", "D1 LAB 406", "D1 LAB 407", "D1 LAB 408", "D1 LAB 409", "D1 LAB 410", "D1 LAB 412", "D1 LAB 413", "D1 LAB 415", "D1 LAB 416", "D1 LAB K08", "D1 LAB K12", "D2 LAB ROOM 122"]}, {"M2"=>["A RING 610", "B LES 100", "B LES 104", "B1 LAB 204", "B2 LAB 219 FEBE COMP LAB", "B3 LAB 11", "C LES 101", "C LES 103", "C LES 301", "C LES 304", "C LES 306", "C LES 401", "C1 LAB 215 LABORATORY", "D LES 309", "D LES 311", "D LES 403", "D LES 405", "D LES 406", "D LES 407", "D LES 410", "D1 LAB 409", "D1 LAB 412", "D1 LAB 414", "D1 LAB K08", "D1 LAB K12", "D2 LAB 333 LABORATORY", "D2 LAB ROOM 122"]}, {"M2"=>["A RING 610", "B LES 100", "B LES 104", "B1 LAB 204", "B2 LAB 219 FEBE COMP LAB", "B3 LAB 11", "C LES 101", "C LES 103", "C LES 301", "C LES 304", "C LES 306", "C LES 401", "C1 LAB 215 LABORATORY", "D LES 309", "D LES 311", "D LES 403", "D LES 405", "D LES 406", "D LES 407", "D LES 410", "D1 LAB 409", "D1 LAB 412", "D1 LAB 414", "D1 LAB K08", "D1 LAB K12", "D2 LAB 333 LABORATORY", "D2 LAB ROOM 122"]}, {"Q1"=>["A LES G01", "A LES G02", "B LES 100", "B LES 101", "B RING 712", "C LES 102", "C LES 201", "C LES 203", "C LES 301", "C LES 401", "C1 LAB 215 LABORATORY", "C1 LAB 304", "D LAB BASEMENT ROOM K01", "D LES 301", "D LES 304", "D LES 306", "D LES 311", "D LES 404", "D LES 405", "D LES 410", "D1 LAB 401", "D1 LAB 406", "D1 LAB 409", "D1 LAB 412", "D1 LAB 413", "D1 LAB 415", "D1 LAB K10", "D1 LAB K12", "D2 LAB 333 LABORATORY", "D2 LAB ROOM 122", "E LES 202 COMPUTER LAB"]}, {"Q2"=>["A LES G01", "A LES G02", "B LES 100", "B RING 712", "C LES 102", "C LES 201", "C LES 203", "C LES 301", "C LES 302", "C LES 305", "C LES 306", "C LES 308", "C LES 401", "C LES 403", "C1 LAB 215 LABORATORY", "C1 LAB 304", "D LES 106", "D LES 301", "D LES 304", "D LES 306", "D LES 311", "D LES 404", "D LES 405", "D LES 406", "D LES 410", "D1 LAB 402", "D1 LAB 406", "D1 LAB 408", "D1 LAB 409", "D1 LAB 410", "D1 LAB 412", "D1 LAB 414", "D1 LAB 415", "D1 LAB 416", "D1 LAB K10", "D1 LAB K12", "D2 LAB 333 LABORATORY", "D2 LAB ROOM 122", "E LES 202 COMPUTER LAB"]}, {"I1"=>["A LES G01", "A LES G02", "A RING 522", "B LES 100", "B LES 103", "B LES 104", "B1 LAB 204", "C LES 101", "C LES 103", "C LES 201", "C LES 202", "C LES 203", "C LES 305", "C LES 306", "C LES 308", "C LES 402", "C LES 403", "C LES 404", "D LES 301", "D LES 307", "D LES 309", "D LES 312", "D LES 405", "D LES 406", "D LES 407", "D LES 410", "D LES 411", "D1 LAB 402", "D1 LAB 416", "D1 LAB K08"], "P6"=>["B LES 103", "B2 LAB 117 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 401", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 103", "D1 LAB K12", "D2 LAB 333 LABORATORY"]}, {"I1"=>["A LES G01", "A LES G02", "A RING 522", "B LES 100", "B LES 103", "B LES 104", "B1 LAB 204", "C LES 101", "C LES 103", "C LES 201", "C LES 202", "C LES 203", "C LES 305", "C LES 306", "C LES 308", "C LES 402", "C LES 403", "C LES 404", "D LES 301", "D LES 307", "D LES 309", "D LES 312", "D LES 405", "D LES 406", "D LES 407", "D LES 410", "D LES 411", "D1 LAB 402", "D1 LAB 416", "D1 LAB K08"], "P6"=>["B LES 103", "B2 LAB 117 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 401", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 103", "D1 LAB K12", "D2 LAB 333 LABORATORY"]}, {"L2"=>["A LES G02", "B LES 100", "B LES 101", "B3 LAB 11", "C LES 103", "C LES 306", "C LES 310", "C LES 402", "C LES 403", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D LES 101", "D LES 102", "D LES 103", "D LES 105", "D LES 204", "D LES 301", "D LES 309", "D1 LAB 401", "D1 LAB 405", "D1 LAB 406", "D1 LAB 410", "D1 LAB 411", "D1 LAB 413", "D1 LAB 415", "D1 LAB K10", "D1 LAB K11", "D2 LAB ROOM 122", "E LES 100"], "P7"=>["B LES 103", "B2 LAB 117 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 401", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 103", "D1 LAB K12", "D2 LAB 333 LABORATORY", "E LES 202 COMPUTER LAB", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 204", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"L2"=>["A LES G02", "B LES 100", "B LES 101", "B3 LAB 11", "C LES 103", "C LES 306", "C LES 310", "C LES 402", "C LES 403", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D LES 101", "D LES 102", "D LES 103", "D LES 105", "D LES 204", "D LES 301", "D LES 309", "D1 LAB 401", "D1 LAB 405", "D1 LAB 406", "D1 LAB 410", "D1 LAB 411", "D1 LAB 413", "D1 LAB 415", "D1 LAB K10", "D1 LAB K11", "D2 LAB ROOM 122", "E LES 100"], "P7"=>["B LES 103", "B2 LAB 117 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 401", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 103", "D1 LAB K12", "D2 LAB 333 LABORATORY", "E LES 202 COMPUTER LAB", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 204", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"K3"=>["A LES G02", "B LES 103", "C LES 102", "C LES 202", "C LES 401", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 308", "D LES 309", "D LES 310", "D LES 311", "D LES 312", "D LES 404", "D LES 405", "D LES 406", "D LES 408", "D LES 410", "D1 LAB 401", "D1 LAB 403", "D1 LAB 404", "D1 LAB 405", "D1 LAB 410", "D1 LAB 411", "D1 LAB K08", "D1 LAB K11"], "P8"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D1 LAB 108", "D2 LAB 333 LABORATORY", "E LES 202 COMPUTER LAB", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 204", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"K3"=>["A LES G02", "B LES 103", "C LES 102", "C LES 202", "C LES 401", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 308", "D LES 309", "D LES 310", "D LES 311", "D LES 312", "D LES 404", "D LES 405", "D LES 406", "D LES 408", "D LES 410", "D1 LAB 401", "D1 LAB 403", "D1 LAB 404", "D1 LAB 405", "D1 LAB 410", "D1 LAB 411", "D1 LAB K08", "D1 LAB K11"], "P8"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D1 LAB 108", "D2 LAB 333 LABORATORY", "E LES 202 COMPUTER LAB", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 204", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"K4"=>["A LES G02", "B LES 103", "C LES 102", "C LES 202", "C LES 401", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K01", "D1 LAB 401", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB K08", "D1 LAB K11"], "P9"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C2 LAB 115 LABORATORY", "D1 LAB 108", "D2 LAB 333 LABORATORY", "E LES 202 COMPUTER LAB", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 204", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"K4"=>["A LES G02", "B LES 103", "C LES 102", "C LES 202", "C LES 401", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K01", "D1 LAB 401", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB K08", "D1 LAB K11"], "P9"=>["B1 LAB 204", "B2 LAB 117 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C2 LAB 115 LABORATORY", "D1 LAB 108", "D2 LAB 333 LABORATORY", "E LES 202 COMPUTER LAB", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 204", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"L3"=>["C LES 402", "C LES 403", "C1 LAB 215 LABORATORY", "C2 LAB 115 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 102", "D LES 103", "E LES 200"]}, {"L4"=>["C LES 304", "C LES 403", "C1 LAB 215 LABORATORY", "D LES 101", "D LES 103", "E LES 200"]}, {"G2"=>["C LES 201", "D1 LAB 108", "D1 LAB 403", "D1 LAB 405", "D1 LAB 411", "D1 LAB 414", "D1 LAB 415"]}, {"M3"=>["A RING 610", "B LES 100", "B LES 101", "B LES 104", "B1 LAB 204", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 203", "C LES 204", "C LES 301", "C LES 302", "C LES 304", "C LES 306", "C LES 308", "C LES 404", "D LAB BASEMENT ROOM K01", "D LES 307", "D LES 309", "D LES 403", "D LES 405", "D LES 407", "D LES 408", "D1 LAB 403", "D1 LAB 405", "D1 LAB 407", "D1 LAB 411", "D1 LAB 412", "D1 LAB 414", "D1 LAB K08", "D2 LAB ROOM 122", "D3 LAB 120 LABORATORY", "E LES 100"]}, {"M3"=>["A RING 610", "B LES 100", "B LES 101", "B LES 104", "B1 LAB 204", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 203", "C LES 204", "C LES 301", "C LES 302", "C LES 304", "C LES 306", "C LES 308", "C LES 404", "D LAB BASEMENT ROOM K01", "D LES 307", "D LES 309", "D LES 403", "D LES 405", "D LES 407", "D LES 408", "D1 LAB 403", "D1 LAB 405", "D1 LAB 407", "D1 LAB 411", "D1 LAB 412", "D1 LAB 414", "D1 LAB K08", "D2 LAB ROOM 122", "D3 LAB 120 LABORATORY", "E LES 100"]}, {"M4"=>["A RING 610", "B LES 100", "B LES 104", "B1 LAB 204", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 204", "C LES 301", "C LES 304", "C LES 308", "D LES 307", "D LES 309", "D LES 405", "D LES 406", "D LES 407", "D LES 408", "D LES 411", "D1 LAB 403", "D1 LAB 405", "D1 LAB 406", "D1 LAB 407", "D1 LAB 409", "D1 LAB 411", "D1 LAB 413", "D1 LAB 416", "D1 LAB K08", "D2 LAB ROOM 122", "D3 LAB 120 LABORATORY", "E LES 100"], "P12"=>["C LES 404", "D LAB BASEMENT ROOM K02", "D1 LAB K09", "D1 LAB K11"]}, {"M4"=>["A RING 610", "B LES 100", "B LES 104", "B1 LAB 204", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 204", "C LES 301", "C LES 304", "C LES 308", "D LES 307", "D LES 309", "D LES 405", "D LES 406", "D LES 407", "D LES 408", "D LES 411", "D1 LAB 403", "D1 LAB 405", "D1 LAB 406", "D1 LAB 407", "D1 LAB 409", "D1 LAB 411", "D1 LAB 413", "D1 LAB 416", "D1 LAB K08", "D2 LAB ROOM 122", "D3 LAB 120 LABORATORY", "E LES 100"], "P12"=>["C LES 404", "D LAB BASEMENT ROOM K02", "D1 LAB K09", "D1 LAB K11"]}, {"T1"=>["B LES 101", "C LES 101", "C LES 103", "C LES 204", "C LES 304", "C LES 306", "C LES 308", "D LES 102", "D LES 106", "D LES 202", "D LES 204", "D LES 301", "D LES 306", "D LES 404", "D1 LAB 402", "D1 LAB 406", "D1 LAB 407", "D1 LAB K08", "D1 LAB K11", "D1 LAB K12", "E LES 100"], "P13"=>["C LES 102", "C LES 203", "C LES 402", "C LES 404", "C1 LAB 221", "C1 LAB 303", "C1 LAB 304", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D1 LAB K09", "D1 LAB K11", "D2 LAB 115 LABORATORY"]}, {"T1"=>["B LES 101", "C LES 101", "C LES 103", "C LES 204", "C LES 304", "C LES 306", "C LES 308", "D LES 102", "D LES 106", "D LES 202", "D LES 204", "D LES 301", "D LES 306", "D LES 404", "D1 LAB 402", "D1 LAB 406", "D1 LAB 407", "D1 LAB K08", "D1 LAB K11", "D1 LAB K12", "E LES 100"], "P13"=>["C LES 102", "C LES 203", "C LES 402", "C LES 404", "C1 LAB 221", "C1 LAB 303", "C1 LAB 304", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D1 LAB K09", "D1 LAB K11", "D2 LAB 115 LABORATORY"]}, {"T2"=>["C LES 101", "C LES 103", "C LES 204", "D LES 102", "D LES 106", "D LES 202", "D LES 204", "D LES 301", "D LES 306", "D LES 311", "D LES 404", "D LES 405", "D LES 408", "D1 LAB 402", "D1 LAB 405", "D1 LAB 406", "D1 LAB 407", "D1 LAB 410", "D1 LAB K08", "D1 LAB K11", "E LES 100"], "P14"=>["C LES 102", "C LES 203", "C LES 402", "C1 LAB 221", "C1 LAB 304", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D1 LAB K09", "D1 LAB K11", "D2 LAB 115 LABORATORY"]}, {"T2"=>["C LES 101", "C LES 103", "C LES 204", "D LES 102", "D LES 106", "D LES 202", "D LES 204", "D LES 301", "D LES 306", "D LES 311", "D LES 404", "D LES 405", "D LES 408", "D1 LAB 402", "D1 LAB 405", "D1 LAB 406", "D1 LAB 407", "D1 LAB 410", "D1 LAB K08", "D1 LAB K11", "E LES 100"], "P14"=>["C LES 102", "C LES 203", "C LES 402", "C1 LAB 221", "C1 LAB 304", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D1 LAB K09", "D1 LAB K11", "D2 LAB 115 LABORATORY"]}, {"S1"=>["A LES G01", "A LES G02", "B LES 100", "B RING 726", "C LES 202", "D LES 104", "D LES 202", "D LES 203", "D LES 301", "D LES 307", "D LES 311", "D LES 405", "D LES 406", "D1 LAB 108", "D1 LAB 402", "D1 LAB 403", "D1 LAB 404", "D1 LAB 405", "D1 LAB 406", "D1 LAB 411", "D1 LAB K08", "D2 LAB 121 LABORATORY"], "P15"=>["C LES 203", "C RING 303 COMPUTER LAB", "C1 LAB 304", "C2 LAB 122 LABORATORY", "D LAB BASEMENT ROOM K02", "D LES 102", "D LES 201", "D1 LAB K08", "D1 LAB K09", "D1 LAB K11", "D2 LAB 115 LABORATORY", "D3 LAB 240 LABORATORY", "E LES 100"]}, {"S2"=>["A LES G01", "A LES G02", "B LES 100", "B RING 712", "C LES 202", "C LES 308", "D LES 203", "D LES 301", "D LES 307", "D LES 406", "D1 LAB 108", "D1 LAB 402", "D1 LAB 403", "D1 LAB 407", "D1 LAB 410", "D1 LAB 411", "D1 LAB K08", "D2 LAB 121 LABORATORY"], "P16"=>["C LES 203", "C1 LAB 304", "C2 LAB 122 LABORATORY", "D LES 102", "D LES 103", "D LES 201", "D1 LAB K08", "D2 LAB 115 LABORATORY", "D3 LAB 240 LABORATORY", "E LES 100"]}, {"J1"=>["A LES G01", "A LES G02", "B LES 100", "C LES 101", "C LES 103", "C LES 301", "C LES 302", "C LES 305", "C LES 307", "C LES 402", "C LES 403", "C LES 404", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 104", "D LES 105", "D LES 201", "D LES 203", "D LES 309", "D LES 310", "D LES 403", "D LES 405", "D LES 406", "D1 LAB 401", "D1 LAB 403", "D1 LAB 404", "D1 LAB 405", "D1 LAB 408", "D1 LAB 409", "D1 LAB 411", "D1 LAB 416", "E LES 100"], "P17"=>["B2 LAB 119 FEBE COMP LAB", "C LES 304", "C RING 303 COMPUTER LAB", "C1 LAB 304", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "D LES 103", "D LES 301", "D1 LAB 108", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D2 LAB 116 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"J1"=>["A LES G01", "A LES G02", "B LES 100", "C LES 101", "C LES 103", "C LES 301", "C LES 302", "C LES 305", "C LES 307", "C LES 402", "C LES 403", "C LES 404", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 104", "D LES 105", "D LES 201", "D LES 203", "D LES 309", "D LES 310", "D LES 403", "D LES 405", "D LES 406", "D1 LAB 401", "D1 LAB 403", "D1 LAB 404", "D1 LAB 405", "D1 LAB 408", "D1 LAB 409", "D1 LAB 411", "D1 LAB 416", "E LES 100"], "P17"=>["B2 LAB 119 FEBE COMP LAB", "C LES 304", "C RING 303 COMPUTER LAB", "C1 LAB 304", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "D LES 103", "D LES 301", "D1 LAB 108", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D2 LAB 116 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"J2"=>["A LES G01", "A LES G02", "B RING 726", "C LES 101", "C LES 103", "C LES 402", "C LES 403", "C LES 404", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 104", "D LES 105", "D LES 201", "D LES 202", "D LES 203", "D LES 310", "D LES 403", "D LES 405", "D LES 406", "D1 LAB 403", "D1 LAB 404", "D1 LAB 408", "D1 LAB 409", "E LES 100"], "P18"=>["B2 LAB 119 FEBE COMP LAB", "C LES 304", "C1 LAB 304", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "D LES 103", "D LES 301", "D1 LAB 108", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D2 LAB 116 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"J2"=>["A LES G01", "A LES G02", "B RING 726", "C LES 101", "C LES 103", "C LES 402", "C LES 403", "C LES 404", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 104", "D LES 105", "D LES 201", "D LES 202", "D LES 203", "D LES 310", "D LES 403", "D LES 405", "D LES 406", "D1 LAB 403", "D1 LAB 404", "D1 LAB 408", "D1 LAB 409", "E LES 100"], "P18"=>["B2 LAB 119 FEBE COMP LAB", "C LES 304", "C1 LAB 304", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "D LES 103", "D LES 301", "D1 LAB 108", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D2 LAB 116 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"C1"=>["A LES G01", "A LES G02", "B LES 100", "C LES 102", "C LES 201", "C LES 202", "C LES 203", "C LES 304", "C LES 307", "C LES 401", "D LES 405", "D1 LAB 401", "D1 LAB 403", "D1 LAB 405", "E LES 200"], "P19"=>["B2 LAB 119 FEBE COMP LAB", "C LES 309", "C RING 307 COMPUTER LAB", "C1 LAB 304", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 116 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"C1"=>["A LES G01", "A LES G02", "B LES 100", "C LES 102", "C LES 201", "C LES 202", "C LES 203", "C LES 304", "C LES 307", "C LES 401", "D LES 405", "D1 LAB 401", "D1 LAB 403", "D1 LAB 405", "E LES 200"], "P19"=>["B2 LAB 119 FEBE COMP LAB", "C LES 309", "C RING 307 COMPUTER LAB", "C1 LAB 304", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 116 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"C2"=>["A LES G01", "A LES G02", "B LES 100", "C LES 102", "C LES 201", "C LES 202", "C LES 203", "C LES 304", "C LES 307", "C LES 401", "D LES 308", "D LES 405", "E LES 200"], "P20"=>["B2 LAB 119 FEBE COMP LAB", "C LES 309", "C1 LAB 303", "C1 LAB 304", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 116 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"C2"=>["A LES G01", "A LES G02", "B LES 100", "C LES 102", "C LES 201", "C LES 202", "C LES 203", "C LES 304", "C LES 307", "C LES 401", "D LES 308", "D LES 405", "E LES 200"], "P20"=>["B2 LAB 119 FEBE COMP LAB", "C LES 309", "C1 LAB 303", "C1 LAB 304", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 116 LABORATORY", "D3 LAB 240 LABORATORY"]}, {"N3"=>["A LES G01", "B RING 712", "C LES 301", "C LES 305", "C LES 402", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 103", "D LES 312", "D1 LAB 108", "D3 LAB 330 LABORATORY"]}, {"N4"=>["A LES G01", "B RING 712", "C LES 402", "C2 LAB 122 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 103", "D LES 312", "D1 LAB 108", "D3 LAB 330 LABORATORY"]}, {"L1"=>["A LES G02", "B LES 100", "B LES 101", "B3 LAB 11", "C LES 103", "C LES 304", "C LES 403", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D LES 101", "D LES 102", "D LES 103", "D LES 105", "D LES 301", "D1 LAB 403", "D1 LAB 405", "D1 LAB 408", "D1 LAB 409", "D1 LAB 412", "D1 LAB K10", "D2 LAB ROOM 122", "E LES 100"]}, {"L2"=>["A LES G02", "B LES 100", "B LES 101", "B3 LAB 11", "C LES 103", "C LES 306", "C LES 310", "C LES 402", "C LES 403", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D LES 101", "D LES 102", "D LES 103", "D LES 105", "D LES 204", "D LES 301", "D LES 309", "D1 LAB 401", "D1 LAB 405", "D1 LAB 406", "D1 LAB 410", "D1 LAB 411", "D1 LAB 413", "D1 LAB 415", "D1 LAB K10", "D1 LAB K11", "D2 LAB ROOM 122", "E LES 100"]}, {"L2"=>["A LES G02", "B LES 100", "B LES 101", "B3 LAB 11", "C LES 103", "C LES 306", "C LES 310", "C LES 402", "C LES 403", "C1 LAB 215 LABORATORY", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D LES 101", "D LES 102", "D LES 103", "D LES 105", "D LES 204", "D LES 301", "D LES 309", "D1 LAB 401", "D1 LAB 405", "D1 LAB 406", "D1 LAB 410", "D1 LAB 411", "D1 LAB 413", "D1 LAB 415", "D1 LAB K10", "D1 LAB K11", "D2 LAB ROOM 122", "E LES 100"]}, {"R1"=>["B LES 100", "B RING 709", "C LES 103", "C LES 203", "C LES 301", "C LES 305", "C LES 306", "C LES 307", "C LES 310", "C LES 402", "C LES 403", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D LES 204", "D LES 309", "D1 LAB 108", "D1 LAB 405", "D1 LAB 408", "D1 LAB 411", "D1 LAB 414", "D1 LAB 416", "D1 LAB K09"], "p21"=>[]}, {"R1"=>["B LES 100", "B RING 709", "C LES 103", "C LES 203", "C LES 301", "C LES 305", "C LES 306", "C LES 307", "C LES 310", "C LES 402", "C LES 403", "D LAB BASEMENT ROOM K02", "D LAB BASEMENT ROOM K03", "D LES 204", "D LES 309", "D1 LAB 108", "D1 LAB 405", "D1 LAB 408", "D1 LAB 411", "D1 LAB 414", "D1 LAB 416", "D1 LAB K09"], "p21"=>[]}, {"R2 P22"=>[]}, {"R2 P22"=>[]}, {"T3"=>["B LES 100", "B LES 101", "C LES 101", "C LES 305", "D LAB BASEMENT ROOM K03", "D LES 104", "D LES 202", "D LES 204", "D LES 301", "D LES 306", "D LES 309", "D LES 311", "D LES 404", "D LES 405", "D LES 406", "D LES 407", "D LES 408", "D LES 410", "D LES 411", "D1 LAB 401", "D1 LAB 402", "D1 LAB 403", "D1 LAB 409", "D1 LAB 412", "D1 LAB 415", "D1 LAB K08", "D2 LAB ROOM 122", "E LES 100"], "P23"=>["B2 LAB 119 FEBE COMP LAB", "B2 LAB 12", "C RING 303 COMPUTER LAB", "C1 LAB 215 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D2 LAB 116 LABORATORY", "D2 LAB 333 LABORATORY"]}, {"T3"=>["B LES 100", "B LES 101", "C LES 101", "C LES 305", "D LAB BASEMENT ROOM K03", "D LES 104", "D LES 202", "D LES 204", "D LES 301", "D LES 306", "D LES 309", "D LES 311", "D LES 404", "D LES 405", "D LES 406", "D LES 407", "D LES 408", "D LES 410", "D LES 411", "D1 LAB 401", "D1 LAB 402", "D1 LAB 403", "D1 LAB 409", "D1 LAB 412", "D1 LAB 415", "D1 LAB K08", "D2 LAB ROOM 122", "E LES 100"], "P23"=>["B2 LAB 119 FEBE COMP LAB", "B2 LAB 12", "C RING 303 COMPUTER LAB", "C1 LAB 215 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D2 LAB 116 LABORATORY", "D2 LAB 333 LABORATORY"]}, {"T4"=>["B LES 100", "B LES 101", "C LES 101", "C LES 302", "D LAB BASEMENT ROOM K03", "D LES 103", "D LES 202", "D LES 204", "D LES 301", "D LES 306", "D LES 308", "D LES 310", "D LES 311", "D LES 405", "D LES 407", "D LES 410", "D LES 411", "D1 LAB 401", "D1 LAB 402", "D1 LAB 404", "D1 LAB 406", "D1 LAB 409", "D1 LAB 412", "D1 LAB 413", "D1 LAB 415", "D1 LAB K08", "D2 LAB ROOM 122", "E LES 100"], "P24"=>["B2 LAB 119 FEBE COMP LAB", "B2 LAB 12", "C1 LAB 215 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D2 LAB 116 LABORATORY", "D2 LAB 333 LABORATORY"]}, {"H3"=>["A LES G01", "A LES G02", "C LES 103", "C LES 204", "C LES 310", "C LES 403", "D LES 105", "D LES 106", "D LES 203", "D LES 308", "D LES 311", "D LES 312", "D LES 408", "D1 LAB 401", "D1 LAB 403", "D1 LAB 409", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413"], "P25"=>["C LES 103", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D LES 201", "D LES 304", "D1 LAB 108", "D1 LAB K10", "D2 LAB 115 LABORATORY", "D2 LAB 333 LABORATORY", "D3 LAB 330 LABORATORY", "E LES 201 COMPUTER LABS"]}, {"H4"=>["A LES G01", "A LES G02", "C LES 103", "C LES 204", "C LES 306", "C LES 308", "C LES 310", "C LES 403", "D LES 105", "D LES 106", "D LES 203", "D LES 308", "D LES 312", "D LES 405", "D1 LAB 401", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D3 LAB 120 LABORATORY"], "P26"=>["A RING 610", "C LES 103", "C RING 307 COMPUTER LAB", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D LES 201", "D LES 304", "D1 LAB 108", "D1 LAB K10", "D2 LAB 115 LABORATORY", "D2 LAB 333 LABORATORY", "D3 LAB 330 LABORATORY", "E LES 201 COMPUTER LABS", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 207"]}, {"H4"=>["A LES G01", "A LES G02", "C LES 103", "C LES 204", "C LES 306", "C LES 308", "C LES 310", "C LES 403", "D LES 105", "D LES 106", "D LES 203", "D LES 308", "D LES 312", "D LES 405", "D1 LAB 401", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D3 LAB 120 LABORATORY"], "P26"=>["A RING 610", "C LES 103", "C RING 307 COMPUTER LAB", "C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D LES 201", "D LES 304", "D1 LAB 108", "D1 LAB K10", "D2 LAB 115 LABORATORY", "D2 LAB 333 LABORATORY", "D3 LAB 330 LABORATORY", "E LES 201 COMPUTER LABS", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 207"]}, {"I3"=>["A LES G01", "A LES G02", "A RING 522", "B LES 100", "C LES 101", "C LES 103", "C LES 301", "C LES 305", "C LES 306", "C LES 308", "C LES 310", "D LAB BASEMENT ROOM K03", "D LES 106", "D LES 301", "D LES 308", "D1 LAB 402", "D1 LAB 403", "D1 LAB 406", "D1 LAB 407", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB K08", "E LES 200"], "P27"=>["C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 333 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 207"]}, {"I3"=>["A LES G01", "A LES G02", "A RING 522", "B LES 100", "C LES 101", "C LES 103", "C LES 301", "C LES 305", "C LES 306", "C LES 308", "C LES 310", "D LAB BASEMENT ROOM K03", "D LES 106", "D LES 301", "D LES 308", "D1 LAB 402", "D1 LAB 403", "D1 LAB 406", "D1 LAB 407", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB K08", "E LES 200"], "P27"=>["C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 333 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 207"]}, {"I4"=>["A LES G01", "A LES G02", "A RING 522", "B LES 100", "C LES 101", "C LES 308", "D LAB BASEMENT ROOM K03", "D LES 101", "D LES 301", "D LES 404", "D LES 405", "D LES 406", "D LES 408", "D1 LAB 402", "D1 LAB 403", "D1 LAB K08", "E LES 200"], "P28"=>["C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 333 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 207"]}, {"I4"=>["A LES G01", "A LES G02", "A RING 522", "B LES 100", "C LES 101", "C LES 308", "D LAB BASEMENT ROOM K03", "D LES 101", "D LES 301", "D LES 404", "D LES 405", "D LES 406", "D LES 408", "D1 LAB 402", "D1 LAB 403", "D1 LAB K08", "E LES 200"], "P28"=>["C1 LAB K001", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 333 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 207"]}, {"O3"=>["A LES G01", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 12", "C LES 102", "C LES 401", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 103", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D2 LAB 333 LABORATORY", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 207"]}, {"O3"=>["A LES G01", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 12", "C LES 102", "C LES 401", "C2 LAB 115 LABORATORY", "C2 LAB 122 LABORATORY", "C2 LAB 123 LABORATORY", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 103", "D1 LAB K12", "D2 LAB 115 LABORATORY", "D2 LAB 333 LABORATORY", "E RING COMPUTER LAB 203", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 207"]}, {"G3"=>["C1 LAB 304", "C2 LAB 123 LABORATORY", "D LAB BASEMENT ROOM K01", "D1 LAB 108", "D2 LAB 333 LABORATORY"]}, {"G4"=>["C LES 101", "C LES 309", "C1 LAB 304", "D1 LAB 108"]}, {"Z3"=>["A LES G02", "B LES 100", "B LES 101", "B LES 104", "C LES 201", "C LES 202", "C LES 204", "C LES 306", "C LES 307", "C LES 309", "C LES 402", "C1 LAB 215 LABORATORY", "D LES 101", "D LES 201", "D1 LAB 108", "D1 LAB 401", "D1 LAB 408", "D1 LAB 409", "D1 LAB K08"]}, {"Z4"=>["A LES G02", "B LES 100", "B LES 101", "B LES 104", "C LES 201", "C LES 202", "C LES 204", "C LES 306", "C LES 307", "C1 LAB 215 LABORATORY", "D LES 101", "D LES 201", "D1 LAB 108", "D1 LAB 401", "D1 LAB 403", "D1 LAB 404", "D1 LAB 405", "D1 LAB 406", "D1 LAB 408", "D1 LAB 409", "D1 LAB K08", "E LES 200"]}, {"Z4"=>["A LES G02", "B LES 100", "B LES 101", "B LES 104", "C LES 201", "C LES 202", "C LES 204", "C LES 306", "C LES 307", "C1 LAB 215 LABORATORY", "D LES 101", "D LES 201", "D1 LAB 108", "D1 LAB 401", "D1 LAB 403", "D1 LAB 404", "D1 LAB 405", "D1 LAB 406", "D1 LAB 408", "D1 LAB 409", "D1 LAB K08", "E LES 200"]}, {"Q3"=>["A LES G01", "B LES 101", "B LES 104", "B RING 712", "B2 LAB 219 FEBE COMP LAB", "C LES 201", "C LES 309", "C LES 401", "C LES 402", "C LES 403", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K02", "D LES 103", "D LES 203", "D LES 305", "D LES 312", "D LES 405", "D1 LAB 401", "D1 LAB 402", "D1 LAB 403", "D1 LAB 406", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D1 LAB 414", "D2 LAB ROOM 122"]}, {"Q3"=>["A LES G01", "B LES 101", "B LES 104", "B RING 712", "B2 LAB 219 FEBE COMP LAB", "C LES 201", "C LES 309", "C LES 401", "C LES 402", "C LES 403", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K02", "D LES 103", "D LES 203", "D LES 305", "D LES 312", "D LES 405", "D1 LAB 401", "D1 LAB 402", "D1 LAB 403", "D1 LAB 406", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D1 LAB 414", "D2 LAB ROOM 122"]}, {"Q4"=>["A LES G01", "B LES 103", "B LES 104", "B RING 712", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 102", "C LES 201", "C LES 203", "C LES 307", "C LES 401", "C LES 402", "D LAB BASEMENT ROOM K02", "D LES 103", "D LES 106", "D LES 203", "D LES 305", "D LES 307", "D LES 405", "D1 LAB 401", "D1 LAB 402", "D1 LAB 403", "D1 LAB 407", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D1 LAB 414", "D1 LAB 415", "D2 LAB ROOM 122"]}, {"Q4"=>["A LES G01", "B LES 103", "B LES 104", "B RING 712", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 219 FEBE COMP LAB", "C LES 102", "C LES 201", "C LES 203", "C LES 307", "C LES 401", "C LES 402", "D LAB BASEMENT ROOM K02", "D LES 103", "D LES 106", "D LES 203", "D LES 305", "D LES 307", "D LES 405", "D1 LAB 401", "D1 LAB 402", "D1 LAB 403", "D1 LAB 407", "D1 LAB 408", "D1 LAB 410", "D1 LAB 411", "D1 LAB 412", "D1 LAB 413", "D1 LAB 414", "D1 LAB 415", "D2 LAB ROOM 122"]}, {"O4"=>["A LES G01", "B LES 103", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 12", "C LES 102", "C LES 301", "C LES 302", "C LES 309", "C LES 401", "C LES 403", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K02", "D LES 103", "D1 LAB 401", "D1 LAB 403", "D1 LAB 416", "D1 LAB K10", "D1 LAB K11", "D1 LAB K12"]}, {"O4"=>["A LES G01", "B LES 103", "B2 LAB 119 FEBE COMP LAB", "B2 LAB 12", "C LES 102", "C LES 301", "C LES 302", "C LES 309", "C LES 401", "C LES 403", "D LAB BASEMENT ROOM K01", "D LAB BASEMENT ROOM K02", "D LES 103", "D1 LAB 401", "D1 LAB 403", "D1 LAB 416", "D1 LAB K10", "D1 LAB K11", "D1 LAB K12"]}, {}, {}, {"J3"=>["A LES G01", "A LES G02", "C LES 102", "C LES 103", "C LES 304", "C LES 307", "C LES 309", "C LES 402", "C LES 403", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 103", "D LES 105", "D1 LAB 401", "D1 LAB 408", "D1 LAB 409", "D1 LAB 412", "D1 LAB 414", "D1 LAB 416", "E LES 100"], "P29"=>["B LES 100", "B2 LAB 119 FEBE COMP LAB", "C LES 204", "C2 LAB 115 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 121 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"J3"=>["A LES G01", "A LES G02", "C LES 102", "C LES 103", "C LES 304", "C LES 307", "C LES 309", "C LES 402", "C LES 403", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 103", "D LES 105", "D1 LAB 401", "D1 LAB 408", "D1 LAB 409", "D1 LAB 412", "D1 LAB 414", "D1 LAB 416", "E LES 100"], "P29"=>["B LES 100", "B2 LAB 119 FEBE COMP LAB", "C LES 204", "C2 LAB 115 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 121 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"J4"=>["A LES G01", "A LES G02", "C LES 101", "C LES 103", "C LES 304", "C LES 307", "C LES 309", "C LES 402", "C LES 403", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 102", "D LES 103", "D LES 105", "D1 LAB 401", "D1 LAB 408", "D1 LAB 409", "D1 LAB 410", "D1 LAB 412", "D1 LAB 414", "D1 LAB 416", "E LES 100"], "P30"=>["B LES 100", "B2 LAB 119 FEBE COMP LAB", "C LES 102", "C LES 204", "C2 LAB 115 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 121 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"J4"=>["A LES G01", "A LES G02", "C LES 101", "C LES 103", "C LES 304", "C LES 307", "C LES 309", "C LES 402", "C LES 403", "D LAB BASEMENT ROOM K01", "D LES 101", "D LES 102", "D LES 103", "D LES 105", "D1 LAB 401", "D1 LAB 408", "D1 LAB 409", "D1 LAB 410", "D1 LAB 412", "D1 LAB 414", "D1 LAB 416", "E LES 100"], "P30"=>["B LES 100", "B2 LAB 119 FEBE COMP LAB", "C LES 102", "C LES 204", "C2 LAB 115 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 121 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"C3"=>["A LES G01", "B LES 104", "C LES 101", "C LES 203", "C LES 304", "C LES 310", "D LES 102", "E LES 100"], "P31"=>["B2 LAB 119 FEBE COMP LAB", "C LES 102", "C2 LAB 115 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 121 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"C3"=>["A LES G01", "B LES 104", "C LES 101", "C LES 203", "C LES 304", "C LES 310", "D LES 102", "E LES 100"], "P31"=>["B2 LAB 119 FEBE COMP LAB", "C LES 102", "C2 LAB 115 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 121 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"C4"=>["A LES G01", "B LES 104", "C LES 203", "C LES 304", "C LES 310", "E LES 100"], "P32"=>["B2 LAB 119 FEBE COMP LAB", "C LES 102", "C2 LAB 115 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 121 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"C4"=>["A LES G01", "B LES 104", "C LES 203", "C LES 304", "C LES 310", "E LES 100"], "P32"=>["B2 LAB 119 FEBE COMP LAB", "C LES 102", "C2 LAB 115 LABORATORY", "D2 LAB 115 LABORATORY", "D2 LAB 121 LABORATORY", "D3 LAB 330 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}, {"S3"=>["B RING 712", "C LES 102", "C LES 204", "C2 LAB 115 LABORATORY", "D2 LAB 121 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]},
         {"S4"=>["B RING 712", "C LES 204", "D2 LAB 121 LABORATORY", "E RING COMPUTER LAB 205", "E RING COMPUTER LAB 206", "E RING COMPUTER LAB 207"]}]

  def get_free_venue(time, day)
    temp = []
    code = convert_time_to_code(time, day)
    code.each do |c|
      @@sorted_array.each do |venue|
        if !exists(c, venue)
          temp.push(venue[0])
        end
      end
    end
    temp
  end
end
