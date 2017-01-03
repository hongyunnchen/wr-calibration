#!/usr/bin/python

"""
Keysight 53230A Universal Frequency Counter/Timer remote control Read Status

Usage:
  Keysight_53230A_ReadStat.py <IP#>  [--meas=<number>]
  Keysight_53230A_ReadStat.py -h | --help

  IP          IP number of the Frequency Counter/Timer
              (for example: 192.168.32.251 which is its DevNet IP number)

Options:
  -h --help            Show this screen.
  --version            Show version.

"""

from docopt import docopt

import sys
import time
import scipy
import struct

#TJP: installed from web python-vxi Alex
import vxi11

import matplotlib.pyplot as plt

############################################################################
##
## If run from commandline, we can test the library
##
if __name__ == "__main__":
  
  arguments = docopt(__doc__,version='Keysight DSO-S 254A version 01')

  if len(sys.argv) == 2:            # just IP number
    freq_cnt =  vxi11.Instrument(sys.argv[1])    
    #freq_cnt =  vxi11.Instrument("192.168.32.251")
    #freq_cnt.write("*RST")
    print(freq_cnt.ask("*IDN?"))
    # Returns 'Agilent Technologies,53230A,MY50001484,02.05-1519.666-1.19-4.15-127-155-35'

    print(freq_cnt.ask("SYSTem:BATTery:ENABle?"))
    #print(freq_cnt.ask("SYSTem:BATTery:LEVel?"))
    print(freq_cnt.ask("SYSTem:BATTery:STATus?"))
    print(freq_cnt.ask("SYSTem:DATE?"))
    print(freq_cnt.ask("SYSTem:TIME?"))
    print(freq_cnt.ask("SYSTem:LANGuage?"))
    print(freq_cnt.ask("INPut1:IMPedance?"))
    print(freq_cnt.ask("INPut2:IMPedance?"))
    print(freq_cnt.ask("CALibration:SECurity:STATe?"))
    print(freq_cnt.ask("CALibration:COUNt?"))
    #print(freq_cnt.ask("MEASure:FREQuency?"))
    #print(freq_cnt.ask("MEASure:FREQuency:BURSt?"))
    #print(freq_cnt.ask("MEASure:FREQuency:PRF?"))
    #print(freq_cnt.ask("MEASure:FREQuency:PRI?"))
    #print(freq_cnt.ask("MEASure:PWIDth:BURSt?"))
    #print(freq_cnt.ask("MEASure:NWIDth:BURSt?"))
    #print(freq_cnt.ask("MEASure:TINTerval?"))
    #print(freq_cnt.ask("MEASure:RTIMe?"))
    #print(freq_cnt.ask("MEASure:FTIMe?"))
    #print(freq_cnt.ask("MEASure:NDUTycycle?"))
    #print(freq_cnt.ask("MEASure:PDUTycycle?"))
    #print(freq_cnt.ask("MEASure:NWIDth?"))
    #print(freq_cnt.ask("MEASure:PWIDth?"))
    #print(freq_cnt.ask("MEASure:PHASe?"))
    #print(freq_cnt.ask("MEASure:TOTalize:TIMed?"))
    #print(freq_cnt.ask("MEASure:ARRay:TSTamp?"))
    print(freq_cnt.ask("INPut1:LEVel:MINimum?"))
    print(freq_cnt.ask("INPut2:LEVel:MINimum?"))                        #
    print(freq_cnt.ask("INPut1:LEVel:MAXimum?"))
    print(freq_cnt.ask("INPut2:LEVel:MAXimum?"))
    print(freq_cnt.ask("INPut1:LEVel:PTPeak?"))                         #
    print(freq_cnt.ask("INPut2:LEVel:PTPeak?"))
    print(freq_cnt.ask("INPut3:STRength?"))
    print(freq_cnt.ask("SENSe:ROSCillator:SOURce?"))
    print(freq_cnt.ask("SENSe:ROSCillator:SOURce:AUTO?"))
    print(freq_cnt.ask("SENSe:ROSCillator:EXTernal:FREQuency?"))
    print(freq_cnt.ask("SYST:ERR?"))                                    #
    print(freq_cnt.ask("STATus:QUEStionable:EVENt?"))                   #
    print(freq_cnt.ask("SENSe:ROSCillator:INTernal:POWer:STANdby?"))
    print(freq_cnt.ask("SENSe:FREQuency:MODE?"))
    print(freq_cnt.ask("SYSTem:TIMeout?"))
    #print(freq_cnt.ask("MEASure:FREQuency?"))
    print(freq_cnt.ask("CONFigure?"))
    #print(freq_cnt.ask("MEASure?"))
    #print(freq_cnt.ask("MEASure:FREQuency?"))
    #print(freq_cnt.ask("MEASure:FREQuency:RATio?"))
    #print(freq_cnt.ask("MEASure:PERiod?"))
    #print(freq_cnt.ask("MEASure:ARRay:TSTamp?"))
    print(freq_cnt.ask("SENSe:TSTamp:RATE?"))
    #print(freq_cnt.ask("MEASure:TINTerval?"))
    #print(freq_cnt.ask("MEASure:RTIMe?"))
    #print(freq_cnt.ask("MEASure:FTIMe?"))
    #print(freq_cnt.ask("MEASure:PWIDth?"))
    #print(freq_cnt.ask("MEASure:NWIDth?"))
    #print(freq_cnt.ask("MEAS:PWID?"))
    #print(freq_cnt.ask("MEASure:PDUTycycle?"))
    #print(freq_cnt.ask("MEASure:NDUTycycle?"))
    #print(freq_cnt.ask("MEAS:PDUT?"))
    #print(freq_cnt.ask("MEASure:PHASe?"))
    print(freq_cnt.ask("FORMat:PHASe?"))
    #print(freq_cnt.ask("MEAS:PHAS? (@1), (@2)"))
    #print(freq_cnt.ask("MEASure:SPERiod? [<channel>]"))
    #print(freq_cnt.ask("MEAS:SPER? (@1)"))
    #print(freq_cnt.ask("MEASure:PERiod?"))
    #print(freq_cnt.ask("MEASure:TOTalize:TIMed?"))
    #print(freq_cnt.ask("MEAS:TOT:TIM?"))
    #print(freq_cnt.ask("INIT?"))
    print(freq_cnt.ask("SENSe:TOTalize:DATA?"))
    #print(freq_cnt.ask("MEASure:FREQuency:BURSt?"))
    #print(freq_cnt.ask("MEAS:FREQ:BURS? (@3)"))
    #print(freq_cnt.ask("MEASure:FREQuency:PRI?"))
    #print(freq_cnt.ask("MEASure:FREQuency:PRF?"))
    #print(freq_cnt.ask("MEASure:PWIDth:BURSt?"))
    #print(freq_cnt.ask("MEASure:NWIDth:BURSt?"))
    print(freq_cnt.ask("INPut1:PROTection?"))
    print(freq_cnt.ask("INPut2:PROTection?"))
    print(freq_cnt.ask("INPut1:IMPedance?"))
    print(freq_cnt.ask("INPut2:IMPedance?"))
    print(freq_cnt.ask("INPut1:RANGe?"))
    print(freq_cnt.ask("INPut2:RANGe?"))
    print(freq_cnt.ask("INPut1:PROBe?"))
    print(freq_cnt.ask("INPut2:PROBe?"))
    print(freq_cnt.ask("INPut1:COUPling?"))
    print(freq_cnt.ask("INPut2:COUPling?"))
    print(freq_cnt.ask("INPut1:FILTer:LPASs:STATe?"))
    print(freq_cnt.ask("INPut2:FILTer:LPASs:STATe?"))
    print(freq_cnt.ask("INPut1:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut1:LEVel2:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel2:ABSolute?"))
    #print(freq_cnt.ask("INPut1:LEVel:MAXimum?"))
    #print(freq_cnt.ask("INPut2:LEVel:MAXimum?"))
    #print(freq_cnt.ask("INPut1:LEVel:MINimum?"))
    #print(freq_cnt.ask("INPut2:LEVel:MINimum?"))
    #print(freq_cnt.ask("INPut1:LEVel:PTPeak?"))
    #print(freq_cnt.ask("INPut2:LEVel:PTPeak?"))
    print(freq_cnt.ask("INPut1:LEVel1:AUTO?"))
    print(freq_cnt.ask("INPut2:LEVel1:AUTO?"))
    #print(freq_cnt.ask("INPut1:LEVel2:AUTO?"))
    #print(freq_cnt.ask("INPut2:LEVel2:AUTO?"))
    print(freq_cnt.ask("INPut1:LEVel1:RELative?"))
    print(freq_cnt.ask("INPut2:LEVel1:RELative?"))
    print(freq_cnt.ask("INPut1:LEVel2:RELative?"))
    print(freq_cnt.ask("INPut2:LEVel2:RELative?"))
    print(freq_cnt.ask("INPut1:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut1:LEVel2:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel2:ABSolute?"))
    print(freq_cnt.ask("SYSTem:ALEVel:FREQuency?"))
    print(freq_cnt.ask("INPut3:BURSt:LEVel?"))
    #print(freq_cnt.ask("INPut1:NREJection?"))
    #print(freq_cnt.ask("INPut2:NREJection?"))
    print(freq_cnt.ask("INPut1:SLOPe1?"))
    print(freq_cnt.ask("INPut1:SLOPe2?"))
    print(freq_cnt.ask("INPut2:SLOPe1?"))
    print(freq_cnt.ask("INPut2:SLOPe2?"))
    #print(freq_cnt.ask("INPut1:LEVel:MINimum?"))
    #print(freq_cnt.ask("INPut2:LEVel:MINimum?"))
    #print(freq_cnt.ask("INPut1:LEVel:MAXimum?"))
    #print(freq_cnt.ask("INPut2:LEVel:MAXimum?"))
    #print(freq_cnt.ask("INPut1:LEVel:PTPeak?"))
    #print(freq_cnt.ask("INPut2:LEVel:PTPeak?"))
    print(freq_cnt.ask("INPut3:STRength?"))
    print(freq_cnt.ask("TRIGger:COUNt?"))
    print(freq_cnt.ask("SAMPle:COUNt?"))
    print(freq_cnt.ask("TRIGger:SOURce?"))
    print(freq_cnt.ask("TRIGger:SLOPe?"))
    print(freq_cnt.ask("TRIGger:DELay?"))
    print(freq_cnt.ask("TRIGger:COUNt?"))
    print(freq_cnt.ask("SAMPle:COUNt?"))
    print(freq_cnt.ask("SENSe:FREQuency:GATE:SOURce?"))
    print(freq_cnt.ask("SENSe:FREQuency:GATE:TIME?"))
    print(freq_cnt.ask("SENS:FREQ:GATE:TIME?"))
    #print(freq_cnt.ask("MEAS:PER?"))
    print(freq_cnt.ask("SENS:FREQ:GATE:TIME?"))
    print(freq_cnt.ask("SENSe:FREQuency:GATE:POLarity?"))
    print(freq_cnt.ask("INPut1:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut1:LEVel2:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel2:ABSolute?"))
    print(freq_cnt.ask("SENSe:TOTalize:GATE:SOURce?"))
    print(freq_cnt.ask("SENSe:TOTalize:GATE:TIME?"))
    print(freq_cnt.ask("SENSe:TOTalize:GATE:POLarity?"))
    print(freq_cnt.ask("INPut1:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut1:LEVel2:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel2:ABSolute?"))
    print(freq_cnt.ask("SENSe:TOTalize:DATA?"))
    print(freq_cnt.ask("SENSe:TINTerval:GATE:SOURce?"))
    print(freq_cnt.ask("SENSe:TINterval:GATE:POLarity?"))
    print(freq_cnt.ask("OUTPut:STATe?"))
    print(freq_cnt.ask("OUTPut:POLarity?"))
    print(freq_cnt.ask("SENSe:FREQuency:BURSt:GATE:NARRow?"))
    print(freq_cnt.ask("SENSe:FREQuency:BURSt:GATE:AUTO?"))
    print(freq_cnt.ask("SENSe:FREQuency:BURSt:GATE:TIME?"))
    print(freq_cnt.ask("SENSe:FREQuency:BURSt:GATE:DELay?"))
    print(freq_cnt.ask("SENSe:GATE:STARt:SOURce?"))
    print(freq_cnt.ask("SENSe:GATE:EXTernal:SOURce?"))
    print(freq_cnt.ask("SENSe:GATE:START:SLOPe?"))
    print(freq_cnt.ask("INPut1:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut1:LEVel2:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel2:ABSolute?"))
    print(freq_cnt.ask("SENSe:GATE:STARt:DELay:SOURce?"))
    print(freq_cnt.ask("SENSe:GATE:STARt:DELay:EVENts?"))
    print(freq_cnt.ask("SENSe:GATE:STARt:DELay:TIME?"))
    print(freq_cnt.ask("SENSe:GATE:STOP:HOLDoff:SOURce?"))
    print(freq_cnt.ask("SENSe:GATE:STOP:HOLDoff:EVENts?"))
    print(freq_cnt.ask("SENSe:GATE:STOP:HOLDoff:TIME?"))
    print(freq_cnt.ask("SENSe:GATE:STOP:SOURce?"))
    print(freq_cnt.ask("SENSe:GATE:EXTernal:SOURce?"))
    print(freq_cnt.ask("SENSe:GATE:STOP:SLOPe?"))
    print(freq_cnt.ask("INPut1:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel1:ABSolute?"))
    print(freq_cnt.ask("INPut1:LEVel2:ABSolute?"))
    print(freq_cnt.ask("INPut2:LEVel2:ABSolute?"))
    print(freq_cnt.ask("CALCulate1:STATe?"))
    print(freq_cnt.ask("CALCulate1:SMOothing:STATe?"))
    print(freq_cnt.ask("CALCulate1:SMOothing:RESPonse?"))
    print(freq_cnt.ask("CALCulate1:SCALe:STATe?"))
    print(freq_cnt.ask("CALCulate1:SCALe:FUNCtion?"))
    print(freq_cnt.ask("CALCulate1:SCALe:REFerence:AUTO?"))
    print(freq_cnt.ask("CALCulate1:SCALe:REFerence?"))
    print(freq_cnt.ask("CALCulate1:SCALe:GAIN?"))
    print(freq_cnt.ask("CALCulate1:SCALe:OFFSet?"))
    print(freq_cnt.ask("CALCulate1:SCALe:INVert?"))
    print(freq_cnt.ask("CALCulate1:SCALe:UNIT:STATe?"))
    print(freq_cnt.ask("CALCulate1:SCALe:UNIT?"))
    print(freq_cnt.ask("CALCulate1:AVERage:STATe?"))
    print(freq_cnt.ask("CALCulate1:AVERage:COUNt:CURRent?"))
    #print(freq_cnt.ask("CALCulate1:AVERage:AVERage?"))
    #print(freq_cnt.ask("CALCulate1:AVERage:MINimum?"))
    #print(freq_cnt.ask("CALCulate1:AVERage:MAXimum?"))
    #print(freq_cnt.ask("CALCulate1:AVERage:PTPeak?"))
    #print(freq_cnt.ask("CALCulate1:AVERage:ADEViation?"))
    #print(freq_cnt.ask("CALCulate1:AVERage:SDEViation?"))
    print(freq_cnt.ask("CALCulate1:LIMit:STATe?"))
    print(freq_cnt.ask("CALCulate1:LIMit:LOWer:DATA?"))
    print(freq_cnt.ask("CALCulate1:LIMit:UPPer:DATA?"))
    print(freq_cnt.ask("STATus:QUEStionable:EVENt?"))
    print(freq_cnt.ask("DISPlay:WINDow:MODE?"))
    print(freq_cnt.ask("CALCulate2:TRANsform:HISTogram:STATe?"))
    #print(freq_cnt.ask("CALCulate2:TRANsform:HISTogram:COUNt?"))
    print(freq_cnt.ask("CALCulate2:TRANsform:HISTogram:POINts?"))
    print(freq_cnt.ask("CALCulate2:TRANsform:HISTogram:RANGe:LOWer?"))
    print(freq_cnt.ask("CALCulate2:TRANsform:HISTogram:RANGe:UPPer?"))
    print(freq_cnt.ask("CALCulate2:TRANsform:HISTogram:RANGe:AUTO?"))
    print(freq_cnt.ask("CALCulate2:TRANsform:HISTogram:RANGe:AUTO:COUNt?"))
    #print(freq_cnt.ask("CALCulate2:TRANsform:HISTogram:ALL?"))
    #print(freq_cnt.ask("CALCulate2:TRANsform:HISTogram:DATA?"))
    print(freq_cnt.ask("FORMat:DATA?"))
    print(freq_cnt.ask("FORMat:BORDer?"))
    print(freq_cnt.ask("MMEMory:CDIRectory?"))
    #print(freq_cnt.ask("MEMory:STATe:VALid?"))
    print(freq_cnt.ask("MEMory:STATe:RECall:AUTO?"))
    print(freq_cnt.ask("MEMory:STATe:RECall:SELect?"))
    print(freq_cnt.ask("MMEMory:CATalog:ALL?"))
    print(freq_cnt.ask("MMEMory:CATalog:STATe?"))
    print(freq_cnt.ask("MMEMory:CATalog:ALL?"))
    print(freq_cnt.ask("MMEMory:CATalog:DATA?"))
    print(freq_cnt.ask("MMEMory:CATalog:STATe?"))
    print(freq_cnt.ask("STATus:QUEStionable:CONDition?"))
    print(freq_cnt.ask("STATus:QUEStionable:EVENt?"))
    print(freq_cnt.ask("STATus:QUEStionable:ENABle?"))
    print(freq_cnt.ask("STATus:OPERation:CONDition?"))               #
    print(freq_cnt.ask("STATus:OPERation:EVENt?"))                   #
    print(freq_cnt.ask("STATus:OPERation:ENABle?"))
    print(freq_cnt.ask("*ESR?"))                                     #
    print(freq_cnt.ask("*ESE?"))
    print(freq_cnt.ask("*STB?"))
    print(freq_cnt.ask("*SRE?"))
  sys.exit()
