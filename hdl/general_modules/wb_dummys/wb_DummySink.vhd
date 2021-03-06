--------------------------------------------------------------------------------
--
-- This VHDL file was generated by EASE/HDL 7.4 Revision 9 from HDL Works B.V.
--
-- Ease library  : work
-- HDL library   : work
-- Host name     : SERING
-- User name     : peterj
-- Time stamp    : Tue Aug 13 12:20:16 2013
--
-- Designed by   : 
-- Company       : 
-- Project info  : 
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Object        : Entity work.DummySink
-- Last modified : Mon Aug 12 10:51:10 2013.
--------------------------------------------------------------------------------

library ieee, work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.wr_fabric_pkg.all;

entity wb_DummySink is
  port(
    snk_i : out    t_wrf_sink_in;
    snk_o : in     t_wrf_sink_out);
end entity wb_DummySink;

--------------------------------------------------------------------------------
-- Object        : Architecture work.DummySink.rtl
-- Last modified : Mon Aug 12 10:51:10 2013.
--------------------------------------------------------------------------------


architecture rtl of wb_DummySink is

begin

	snk_i <= c_dummy_snk_in;

end architecture rtl ; -- of DummySink

