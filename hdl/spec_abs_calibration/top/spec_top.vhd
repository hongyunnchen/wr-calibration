--------------------------------------------------------------------------------
--
-- This VHDL file was generated by EASE/HDL 8.3 Revision 5 from HDL Works B.V.
--
-- Ease library  : work
-- HDL library   : work
-- Host name     : SERING
-- User name     : peterj
-- Time stamp    : Mon Nov 07 14:33:06 2016
--
-- Designed by   : 
-- Company       : 
-- Project info  : 
--
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Object        : Entity work.spec_top
-- Last modified : Mon Nov 07 14:32:57 2016
--------------------------------------------------------------------------------



library ieee, work, UNISIM;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.gn4124_core_pkg.all;
use work.gencores_pkg.all;
use work.wrcore_pkg.all;
use work.wr_fabric_pkg.all;
use work.endpoint_pkg.all;
use work.etherbone_pkg.all;
use UNISIM.VCOMPONENTS.all;
use work.wishbone_pkg.all;

entity spec_top is
  port (
    GPIO                     : inout  std_logic_vector(1 downto 0);
    L2P_CLKn                 : out    std_logic;
    L2P_CLKp                 : out    std_logic;
    L2P_DATA                 : out    std_logic_vector(15 downto 0);
    L2P_DFRAME               : out    std_logic;
    L2P_EDB                  : out    std_logic;
    L2P_RDY                  : in     std_logic;
    L2P_VALID                : out    std_logic;
    LED_GREEN                : out    std_logic;
    LED_RED                  : out    std_logic;
    L_CLKn                   : in     std_logic;
    L_CLKp                   : in     std_logic;
    L_RST_N                  : in     std_logic;
    L_WR_RDY                 : in     std_logic_vector(1 downto 0);
    P2L_CLKn                 : in     std_logic;
    P2L_CLKp                 : in     std_logic;
    P2L_DATA                 : in     std_logic_vector(15 downto 0);
    P2L_DFRAME               : in     std_logic;
    P2L_RDY                  : out    std_logic;
    P2L_VALID                : in     std_logic;
    P_RD_D_RDY               : in     std_logic_vector(1 downto 0);
    P_WR_RDY                 : out    std_logic_vector(1 downto 0);
    P_WR_REQ                 : in     std_logic_vector(1 downto 0);
    RX_ERROR                 : out    std_logic;
    TX_ERROR                 : in     std_logic;
    VC_RDY                   : in     std_logic_vector(1 downto 0);
    button1_i                : in     std_logic := 'H';
    button2_i                : in     std_logic := 'H';
    clk_125m_pllref_n_i      : in     std_logic;
    clk_125m_pllref_p_i      : in     std_logic;
    clk_20m_vcxo_i           : in     std_logic;
    dac_clr_n_o              : out    std_logic;
    dac_cs1_n_o              : out    std_logic;
    dac_cs2_n_o              : out    std_logic;
    dac_din_o                : out    std_logic;
    dac_sclk_o               : out    std_logic;
    dio_clk_n_i              : in     std_logic;
    dio_clk_p_i              : in     std_logic;
    dio_led_bot_o            : out    std_logic;
    dio_led_top_o            : out    std_logic;
    dio_n_i                  : in     std_logic_vector(4 downto 0);
    dio_n_o                  : out    std_logic_vector(4 downto 0);
    dio_oe_n_o               : out    std_logic_vector(4 downto 0);
    dio_onewire_b            : inout  std_logic;
    dio_p_i                  : in     std_logic_vector(4 downto 0);
    dio_p_o                  : out    std_logic_vector(4 downto 0);
    dio_sdn_ck_n_o           : out    std_logic;
    dio_sdn_n_o              : out    std_logic;
    dio_term_en_o            : out    std_logic_vector(4 downto 0);
    fpga_pll_ref_clk_101_n_i : in     std_logic;
    fpga_pll_ref_clk_101_p_i : in     std_logic;
    fpga_scl_b               : inout  std_logic;
    fpga_sda_b               : inout  std_logic;
    sfp_los_i                : in     std_logic;
    sfp_mod_def0_b           : in     std_logic;
    sfp_mod_def1_b           : inout  std_logic;
    sfp_mod_def2_b           : inout  std_logic;
    sfp_rate_select_b        : inout  std_logic;
    sfp_rxn_i                : in     std_logic;
    sfp_rxp_i                : in     std_logic;
    sfp_tx_disable_o         : out    std_logic;
    sfp_tx_fault_i           : in     std_logic;
    sfp_txn_o                : out    std_logic;
    sfp_txp_o                : out    std_logic;
    spi_miso_i               : in     std_logic := 'L';
    spi_mosi_o               : out    std_logic;
    spi_ncs_o                : out    std_logic;
    spi_sclk_o               : out    std_logic;
    thermo_id                : inout  std_logic;
    uart_rxd_i               : in     std_logic;
    uart_txd_o               : out    std_logic);
end entity spec_top;

--------------------------------------------------------------------------------
-- Object        : Architecture work.spec_top.rtl
-- Last modified : Mon Nov 07 14:32:57 2016
--------------------------------------------------------------------------------

architecture rtl of spec_top is

    constant c_BAR0_APERTURE     : integer := 20;
    constant c_CSR_WB_SLAVES_NB  : integer := 1;
    constant c_DMA_WB_SLAVES_NB  : integer := 1;
    constant c_DMA_WB_ADDR_WIDTH : integer := 26;
  signal clk_sys              : std_logic;
  signal clk_ext              : std_logic;
  signal clk_ext_mul          : std_logic;
  signal ext_pll_reset        : std_logic;
  signal local_reset_n        : std_logic;
  signal pllout_clk_fb_pllref : std_logic;
  signal pllout_clk_sys       : std_logic;
  signal pllout_clk_fb_dmtd   : std_logic;
  signal pllout_clk_dmtd      : std_logic;
  signal clk_dmtd             : std_logic;
  signal clk_20m_vcxo_buf     : std_logic;
  signal phy_tx_data          : std_logic_vector(7 downto 0);
  signal phy_tx_disparity     : std_logic;
  signal phy_tx_enc_err       : std_logic;
  signal phy_rst              : std_logic;
  signal gtp_dedicated_clk    : std_logic;
  signal dac_cs_n_o           : std_logic_vector(1 downto 0);
  signal clk_125m_pllref      : std_logic;
  signal dio_in               : std_logic_vector(4 downto 0);
  signal dio_out              : std_logic_vector(4 downto 0);
  signal pps                  : std_logic;
  signal phy_rx_data          : std_logic_vector(7 downto 0);
  signal phy_rx_bitslide      : std_logic_vector(3 downto 0);
  signal phy_rx_enc_err       : std_logic;
  signal phy_rx_rbclk         : std_logic;
  signal phy_prbs_sel         : std_logic_vector(2 downto 0);
  signal clk_ext_mul_locked   : std_logic;
  signal phy_loopen           : std_logic;
  signal phy_loopen_vec       : std_logic_vector(2 downto 0);
  signal phy_rdy              : std_logic;
  signal phy_tx_k             : std_logic_vector(0 downto 0);
  signal phy_rx_k             : std_logic_vector(0 downto 0);
  signal csr_dat_o            : std_logic_vector(31 downto 0);
  signal csr_sel_o            : std_logic_vector(3 downto 0);
  signal csr_stb_o            : std_logic;
  signal csr_we_o             : std_logic;
  signal csr_cyc_o            : std_logic;
  signal csr_dat_i            : std_logic_vector(31 downto 0);
  signal genum_csr_ack_i      : std_logic;
  signal csr_stall_i          : std_logic;
  signal dma_reg_adr_i        : std_logic_vector(31 downto 0);
  signal dma_reg_dat_i        : std_logic_vector(31 downto 0);
  signal dma_reg_sel_i        : std_logic_vector(3 downto 0);
  signal dma_reg_stb_i        : std_logic;
  signal dma_reg_we_i         : std_logic;
  signal dma_reg_cyc_i        : std_logic;
  signal dma_reg_dat_o        : std_logic_vector(31 downto 0);
  signal dma_reg_ack_o        : std_logic;
  signal dma_reg_stall_o      : std_logic;
  signal dma_dat_i            : std_logic_vector(31 downto 0);
  signal dma_ack_i            : std_logic;
  signal dma_stall_i          : std_logic;
  signal dma_adr_o            : std_logic_vector(31 downto 0);
  signal dma_dat_o            : std_logic_vector(31 downto 0);
  signal dma_sel_o            : std_logic_vector(3 downto 0);
  signal dma_stb_o            : std_logic;
  signal dma_we_o             : std_logic;
  signal dma_cyc_o            : std_logic;
  signal wb_adr               : std_logic_vector(31 downto 0);
  signal led_divider          : unsigned(23 downto 0);
  signal slave_i              : t_wishbone_slave_in_array(2-1 downto 0);
  signal etherbone_wb_out     : t_wishbone_master_out;
  signal slave_o              : t_wishbone_slave_out_array(2-1 downto 0);
  signal etherbone_wb_in      : t_wishbone_master_in;
  signal genum_wb_in          : t_wishbone_master_in;
  signal genum_wb_out         : t_wishbone_master_out;
  signal rst                  : std_logic;
  signal master_i             : t_wishbone_master_in_array(1-1 downto 0);
  signal master_o             : t_wishbone_master_out_array(1-1 downto 0);
  signal l_clk                : std_logic;
  signal dma_err_i            : std_logic;
  signal dma_rty_i            : std_logic;
  signal dma_int_i            : std_logic;
  signal csr_err_i            : std_logic;
  signal csr_rty_i            : std_logic;
  signal csr_int_i            : std_logic;
  signal clk_in_stopped_o     : std_logic;
  signal clk_ext_rst_o        : std_logic;
  signal pps_led              : std_logic;
  signal dac_dpll_data        : std_logic_vector(15 downto 0);
  signal dac_dpll_load_p1     : std_logic;
  signal dac_hpll_data        : std_logic_vector(15 downto 0);
  signal dac_hpll_load_p1     : std_logic;
  signal wrc_scl_o            : std_logic;
  signal wrc_scl_i            : std_logic;
  signal wrc_sda_o            : std_logic;
  signal wrc_sda_i            : std_logic;
  signal sfp_scl_o            : std_logic;
  signal sfp_scl_i            : std_logic := '1';
  signal sfp_sda_o            : std_logic;
  signal sfp_sda_i            : std_logic := '1';
  signal owr_en               : std_logic_vector(1 downto 0);
  signal owr_i                : std_logic_vector(1 downto 0) := (others => '1');
  signal etherbone_snk_in     : t_wrf_sink_in;
  signal etherbone_snk_out    : t_wrf_sink_out;
  signal etherbone_src_out    : t_wrf_source_out;
  signal etherbone_src_in     : t_wrf_source_in;
  signal etherbone_cfg_in     : t_wishbone_slave_in;
  signal etherbone_cfg_out    : t_wishbone_slave_out;
  signal etherbone_rst_n      : std_logic;
  signal wrc_slave_o          : t_wishbone_slave_out;
  signal wrc_slave_i          : t_wishbone_slave_in;

  component spec_reset_gen
    port (
      clk_sys_i        : in     std_logic;
      rst_pcie_n_a_i   : in     std_logic;
      rst_button_n_a_i : in     std_logic;
      rst_n_o          : out    std_logic);
  end component spec_reset_gen;

  component ext_pll_10_to_125m
    port (
      clk_ext_i        : in     std_logic;
      clk_ext_mul_o    : out    std_logic;
      rst_a_i          : in     std_logic;
      locked_o         : out    std_logic;
      clk_in_stopped_o : out    std_logic);
  end component ext_pll_10_to_125m;

  component gc_extend_pulse
    generic(
      g_width : natural := 1000);
    port (
      clk_i      : in     std_logic;
      rst_n_i    : in     std_logic;
      pulse_i    : in     std_logic;
      extended_o : out    std_logic := '0');
  end component gc_extend_pulse;

  component spec_serial_dac_arb
    generic(
      g_invert_sclk    : boolean;
      g_num_extra_bits : integer);
    port (
      clk_i       : in     std_logic;
      rst_n_i     : in     std_logic;
      val1_i      : in     std_logic_vector(15 downto 0);
      load1_i     : in     std_logic;
      val2_i      : in     std_logic_vector(15 downto 0);
      load2_i     : in     std_logic;
      dac_cs_n_o  : out    std_logic_vector(1 downto 0);
      dac_clr_n_o : out    std_logic;
      dac_sclk_o  : out    std_logic;
      dac_din_o   : out    std_logic);
  end component spec_serial_dac_arb;

  component wr_gtp_phy_spartan6
    generic(
      g_simulation      : integer := 1;
      g_force_disparity : integer := 0;
      g_enable_ch0      : integer := 1;
      g_enable_ch1      : integer := 1);
    port (
      gtp_clk_i          : in     std_logic;
      ch0_ref_clk_i      : in     std_logic;
      ch0_tx_data_i      : in     std_logic_vector(7 downto 0);
      ch0_tx_k_i         : in     std_logic;
      ch0_tx_disparity_o : out    std_logic;
      ch0_tx_enc_err_o   : out    std_logic;
      ch0_rx_rbclk_o     : out    std_logic;
      ch0_rx_data_o      : out    std_logic_vector(7 downto 0);
      ch0_rx_k_o         : out    std_logic;
      ch0_rx_enc_err_o   : out    std_logic;
      ch0_rx_bitslide_o  : out    std_logic_vector(3 downto 0);
      ch0_rst_i          : in     std_logic;
      ch0_loopen_i       : in     std_logic;
      ch0_loopen_vec_i   : in     std_logic_vector(2 downto 0) := (others=>'0');
      ch0_tx_prbs_sel_i  : in     std_logic_vector(2 downto 0) := (others=>'0');
      ch0_rdy_o          : out    std_logic;
      ch1_ref_clk_i      : in     std_logic;
      ch1_tx_data_i      : in     std_logic_vector(7 downto 0) := "00000000";
      ch1_tx_k_i         : in     std_logic := '0';
      ch1_tx_disparity_o : out    std_logic;
      ch1_tx_enc_err_o   : out    std_logic;
      ch1_rx_data_o      : out    std_logic_vector(7 downto 0);
      ch1_rx_rbclk_o     : out    std_logic;
      ch1_rx_k_o         : out    std_logic;
      ch1_rx_enc_err_o   : out    std_logic;
      ch1_rx_bitslide_o  : out    std_logic_vector(3 downto 0);
      ch1_rst_i          : in     std_logic := '0';
      ch1_loopen_i       : in     std_logic := '0';
      ch1_loopen_vec_i   : in     std_logic_vector(2 downto 0) := (others=>'0');
      ch1_tx_prbs_sel_i  : in     std_logic_vector(2 downto 0) := (others=>'0');
      ch1_rdy_o          : out    std_logic;
      pad_txn0_o         : out    std_logic;
      pad_txp0_o         : out    std_logic;
      pad_rxn0_i         : in     std_logic := '0';
      pad_rxp0_i         : in     std_logic := '0';
      pad_txn1_o         : out    std_logic;
      pad_txp1_o         : out    std_logic;
      pad_rxn1_i         : in     std_logic := '0';
      pad_rxp1_i         : in     std_logic := '0');
  end component wr_gtp_phy_spartan6;

  component eb_slave_core
    generic(
      g_sdb_address    : std_logic_vector(63 downto 0);
      g_timeout_cycles : natural;
      g_mtu            : natural);
    port (
      clk_i       : in     std_logic;
      nRst_i      : in     std_logic;
      snk_i       : in     t_wrf_sink_in;
      snk_o       : out    t_wrf_sink_out;
      src_o       : out    t_wrf_source_out;
      src_i       : in     t_wrf_source_in;
      cfg_slave_o : out    t_wishbone_slave_out;
      cfg_slave_i : in     t_wishbone_slave_in;
      master_o    : out    t_wishbone_master_out;
      master_i    : in     t_wishbone_master_in);
  end component eb_slave_core;

begin
  dio_led_bot_o <= '0';
  dac_cs2_n_o <= dac_cs_n_o(1);
  dac_cs1_n_o <= dac_cs_n_o(0);
  dio_out(0) <= pps;
  slave_i(1) <= etherbone_wb_out;
  slave_i(0) <= genum_wb_out;
  etherbone_wb_in <= slave_o(1);
  genum_wb_in <= slave_o(0);
  master_i(0) <= wrc_slave_o;
  wrc_slave_i <= master_o(0);

  gen_dio_iobufs: for i in 0 to 4 generate
  begin

      U_obuf: OBUFDS
        generic map(
          CAPACITANCE => "DONT_CARE",
          IOSTANDARD  => "DEFAULT",
          SLEW        => "SLOW")
        port map(
          O  => dio_p_o(i),
          OB => dio_n_o(i),
          I  => dio_out(i));

      U_ibuf: IBUFDS
        generic map(
          CAPACITANCE      => "DONT_CARE",
          DIFF_TERM        => true,
          IBUF_DELAY_VALUE => "0",
          IBUF_LOW_PWR     => TRUE,
          IFD_DELAY_VALUE  => "AUTO",
          IOSTANDARD       => "DEFAULT",
          DQS_BIAS         => "FALSE")
        port map(
          O  => dio_in(i),
          I  => dio_p_i(i),
          IB => dio_n_i(i));
  end generate gen_dio_iobufs;

  U_Reset_Gen: spec_reset_gen
    port map(
      clk_sys_i        => clk_sys,
      rst_pcie_n_a_i   => L_RST_N,
      rst_button_n_a_i => button1_i,
      rst_n_o          => local_reset_n);

  U_Ext_PLL: ext_pll_10_to_125m
    port map(
      clk_ext_i        => clk_ext,
      clk_ext_mul_o    => clk_ext_mul,
      rst_a_i          => ext_pll_reset,
      locked_o         => clk_ext_mul_locked,
      clk_in_stopped_o => clk_in_stopped_o);

  U_input_buffer: IBUFGDS
    generic map(
      CAPACITANCE      => "DONT_CARE",
      DIFF_TERM        => TRUE,
      IBUF_DELAY_VALUE => "0",
      IBUF_LOW_PWR     => TRUE,
      IOSTANDARD       => "DEFAULT")
    port map(
      O  => clk_ext,
      I  => dio_clk_p_i,
      IB => dio_clk_n_i);

  U_Extend_EXT_Reset: gc_extend_pulse
    generic map(
      g_width => 1000)
    port map(
      clk_i      => clk_sys,
      rst_n_i    => local_reset_n,
      pulse_i    => clk_ext_rst_o,
      extended_o => ext_pll_reset);

  U_Extend_PPS: gc_extend_pulse
    generic map(
      g_width => 10000000)
    port map(
      clk_i      => clk_125m_pllref,
      rst_n_i    => local_reset_n,
      pulse_i    => pps_led,
      extended_o => dio_led_top_o);

  cmp_sys_clk_pll: PLL_BASE
    generic map(
      BANDWIDTH             => "OPTIMIZED",
      CLKFBOUT_MULT         => 8,
      CLKFBOUT_PHASE        => 0.000,
      CLKIN_PERIOD          => 8.0,
      CLKOUT0_DIVIDE        => 16,
      CLKOUT0_DUTY_CYCLE    => 0.500,
      CLKOUT0_PHASE         => 0.000,
      CLKOUT1_DIVIDE        => 16,
      CLKOUT1_DUTY_CYCLE    => 0.500,
      CLKOUT1_PHASE         => 0.000,
      CLKOUT2_DIVIDE        => 16,
      CLKOUT2_DUTY_CYCLE    => 0.500,
      CLKOUT2_PHASE         => 0.000,
      CLKOUT3_DIVIDE        => 1,
      CLKOUT3_DUTY_CYCLE    => 0.5,
      CLKOUT3_PHASE         => 0.0,
      CLKOUT4_DIVIDE        => 1,
      CLKOUT4_DUTY_CYCLE    => 0.5,
      CLKOUT4_PHASE         => 0.0,
      CLKOUT5_DIVIDE        => 1,
      CLKOUT5_DUTY_CYCLE    => 0.5,
      CLKOUT5_PHASE         => 0.0,
      CLK_FEEDBACK          => "CLKFBOUT",
      COMPENSATION          => "INTERNAL",
      DIVCLK_DIVIDE         => 1,
      REF_JITTER            => 0.016,
      RESET_ON_LOSS_OF_LOCK => FALSE)
    port map(
      CLKFBOUT => pllout_clk_fb_pllref,
      CLKOUT0  => pllout_clk_sys,
      CLKOUT1  => open,
      CLKOUT2  => open,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => open,
      CLKFBIN  => pllout_clk_fb_pllref,
      CLKIN    => clk_125m_pllref,
      RST      => '0');

  cmp_clk_sys_buf: BUFG
    port map(
      O => clk_sys,
      I => pllout_clk_sys);

  cmp_dmtd_clk_pll: PLL_BASE
    generic map(
      BANDWIDTH             => "OPTIMIZED",
      CLKFBOUT_MULT         => 50,
      CLKFBOUT_PHASE        => 0.000,
      CLKIN_PERIOD          => 50.0,
      CLKOUT0_DIVIDE        => 16,
      CLKOUT0_DUTY_CYCLE    => 0.500,
      CLKOUT0_PHASE         => 0.000,
      CLKOUT1_DIVIDE        => 16,
      CLKOUT1_DUTY_CYCLE    => 0.500,
      CLKOUT1_PHASE         => 0.000,
      CLKOUT2_DIVIDE        => 8,
      CLKOUT2_DUTY_CYCLE    => 0.500,
      CLKOUT2_PHASE         => 0.000,
      CLKOUT3_DIVIDE        => 1,
      CLKOUT3_DUTY_CYCLE    => 0.5,
      CLKOUT3_PHASE         => 0.0,
      CLKOUT4_DIVIDE        => 1,
      CLKOUT4_DUTY_CYCLE    => 0.5,
      CLKOUT4_PHASE         => 0.0,
      CLKOUT5_DIVIDE        => 1,
      CLKOUT5_DUTY_CYCLE    => 0.5,
      CLKOUT5_PHASE         => 0.0,
      CLK_FEEDBACK          => "CLKFBOUT",
      COMPENSATION          => "INTERNAL",
      DIVCLK_DIVIDE         => 1,
      REF_JITTER            => 0.016,
      RESET_ON_LOSS_OF_LOCK => FALSE)
    port map(
      CLKFBOUT => pllout_clk_fb_dmtd,
      CLKOUT0  => pllout_clk_dmtd,
      CLKOUT1  => open,
      CLKOUT2  => open,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => open,
      CLKFBIN  => pllout_clk_fb_dmtd,
      CLKIN    => clk_20m_vcxo_buf,
      RST      => '0');

  cmp_clk_dmtd_buf: BUFG
    port map(
      O => clk_dmtd,
      I => pllout_clk_dmtd);

  cmp_clk_vcxo: BUFG
    port map(
      O => clk_20m_vcxo_buf,
      I => clk_20m_vcxo_i);

  cmp_gtp_dedicated_clk_buf: IBUFGDS
    generic map(
      CAPACITANCE      => "DONT_CARE",
      DIFF_TERM        => TRUE,
      IBUF_DELAY_VALUE => "0",
      IBUF_LOW_PWR     => TRUE,
      IOSTANDARD       => "DEFAULT")
    port map(
      O  => gtp_dedicated_clk,
      I  => fpga_pll_ref_clk_101_p_i,
      IB => fpga_pll_ref_clk_101_n_i);

  U_DAC_ARB: spec_serial_dac_arb
    generic map(
      g_invert_sclk    => false,
      g_num_extra_bits => 8)
    port map(
      clk_i       => clk_sys,
      rst_n_i     => local_reset_n,
      val1_i      => dac_dpll_data,
      load1_i     => dac_dpll_load_p1,
      val2_i      => dac_hpll_data,
      load2_i     => dac_hpll_load_p1,
      dac_cs_n_o  => dac_cs_n_o,
      dac_clr_n_o => dac_clr_n_o,
      dac_sclk_o  => dac_sclk_o,
      dac_din_o   => dac_din_o);

  cmp_pllrefclk_buf: IBUFGDS
    generic map(
      CAPACITANCE      => "DONT_CARE",
      DIFF_TERM        => TRUE,
      IBUF_DELAY_VALUE => "0",
      IBUF_LOW_PWR     => TRUE,
      IOSTANDARD       => "DEFAULT")
    port map(
      O  => clk_125m_pllref,
      I  => clk_125m_pllref_p_i,
      IB => clk_125m_pllref_n_i);

  cmp_gn4124_core: gn4124_core
    generic map(
      g_ACK_TIMEOUT => 100)
    port map(
      rst_n_a_i       => L_RST_N,
      status_o        => open,
      p2l_clk_p_i     => P2L_CLKp,
      p2l_clk_n_i     => P2L_CLKn,
      p2l_data_i      => P2L_DATA,
      p2l_dframe_i    => P2L_DFRAME,
      p2l_valid_i     => P2L_VALID,
      p2l_rdy_o       => P2L_RDY,
      p_wr_req_i      => P_WR_REQ,
      p_wr_rdy_o      => P_WR_RDY,
      rx_error_o      => RX_ERROR,
      vc_rdy_i        => VC_RDY,
      l2p_clk_p_o     => L2P_CLKp,
      l2p_clk_n_o     => L2P_CLKn,
      l2p_data_o      => L2P_DATA,
      l2p_dframe_o    => L2P_DFRAME,
      l2p_valid_o     => L2P_VALID,
      l2p_edb_o       => L2P_EDB,
      l2p_rdy_i       => L2P_RDY,
      l_wr_rdy_i      => L_WR_RDY,
      p_rd_d_rdy_i    => P_RD_D_RDY,
      tx_error_i      => TX_ERROR,
      dma_irq_o       => open,
      irq_p_i         => '0',
      irq_p_o         => GPIO(0),
      dma_reg_clk_i   => clk_sys,
      dma_reg_adr_i   => dma_reg_adr_i,
      dma_reg_dat_i   => dma_reg_dat_i,
      dma_reg_sel_i   => dma_reg_sel_i,
      dma_reg_stb_i   => dma_reg_stb_i,
      dma_reg_we_i    => dma_reg_we_i,
      dma_reg_cyc_i   => dma_reg_cyc_i,
      dma_reg_dat_o   => dma_reg_dat_o,
      dma_reg_ack_o   => dma_reg_ack_o,
      dma_reg_stall_o => dma_reg_stall_o,
      csr_clk_i       => clk_sys,
      csr_adr_o       => wb_adr,
      csr_dat_o       => csr_dat_o,
      csr_sel_o       => csr_sel_o,
      csr_stb_o       => csr_stb_o,
      csr_we_o        => csr_we_o,
      csr_cyc_o       => csr_cyc_o,
      csr_dat_i       => csr_dat_i,
      csr_ack_i       => genum_csr_ack_i,
      csr_stall_i     => csr_stall_i,
      dma_clk_i       => clk_sys,
      dma_adr_o       => dma_adr_o,
      dma_dat_o       => dma_dat_o,
      dma_sel_o       => dma_sel_o,
      dma_stb_o       => dma_stb_o,
      dma_we_o        => dma_we_o,
      dma_cyc_o       => dma_cyc_o,
      dma_dat_i       => dma_dat_i,
      dma_ack_i       => dma_ack_i,
      dma_stall_i     => dma_stall_i,
      dma_err_i       => dma_err_i,
      dma_rty_i       => dma_rty_i,
      dma_int_i       => dma_int_i,
      csr_int_i       => csr_int_i,
      csr_rty_i       => csr_rty_i,
      csr_err_i       => csr_err_i);

  U_GTP: wr_gtp_phy_spartan6
    generic map(
      g_simulation      => 0,
      g_force_disparity => 0,
      g_enable_ch0      => 0,
      g_enable_ch1      => 1)
    port map(
      gtp_clk_i          => gtp_dedicated_clk,
      ch0_ref_clk_i      => clk_125m_pllref,
      ch0_tx_data_i      => x"00",
      ch0_tx_k_i         => '0',
      ch0_tx_disparity_o => open,
      ch0_tx_enc_err_o   => open,
      ch0_rx_rbclk_o     => open,
      ch0_rx_data_o      => open,
      ch0_rx_k_o         => open,
      ch0_rx_enc_err_o   => open,
      ch0_rx_bitslide_o  => open,
      ch0_rst_i          => '1',
      ch0_loopen_i       => '0',
      ch0_loopen_vec_i   => "000",
      ch0_tx_prbs_sel_i  => "000",
      ch0_rdy_o          => open,
      ch1_ref_clk_i      => clk_125m_pllref,
      ch1_tx_data_i      => phy_tx_data,
      ch1_tx_k_i         => phy_tx_k(0),
      ch1_tx_disparity_o => phy_tx_disparity,
      ch1_tx_enc_err_o   => phy_tx_enc_err,
      ch1_rx_data_o      => phy_rx_data,
      ch1_rx_rbclk_o     => phy_rx_rbclk,
      ch1_rx_k_o         => phy_rx_k(0),
      ch1_rx_enc_err_o   => phy_rx_enc_err,
      ch1_rx_bitslide_o  => phy_rx_bitslide,
      ch1_rst_i          => phy_rst,
      ch1_loopen_i       => phy_loopen,
      ch1_loopen_vec_i   => phy_loopen_vec,
      ch1_tx_prbs_sel_i  => phy_prbs_sel,
      ch1_rdy_o          => phy_rdy,
      pad_txn0_o         => open,
      pad_txp0_o         => open,
      pad_rxn0_i         => '0',
      pad_rxp0_i         => '0',
      pad_txn1_o         => sfp_txn_o,
      pad_txp1_o         => sfp_txp_o,
      pad_rxn1_i         => sfp_rxn_i,
      pad_rxp1_i         => sfp_rxp_i);

  Etherbone: eb_slave_core
    generic map(
      g_sdb_address    => x"0000000000030000",
      g_timeout_cycles => 6250000,
      g_mtu            => 1500)
    port map(
      clk_i       => clk_sys,
      nRst_i      => etherbone_rst_n,
      snk_i       => etherbone_snk_in,
      snk_o       => etherbone_snk_out,
      src_o       => etherbone_src_out,
      src_i       => etherbone_src_in,
      cfg_slave_o => etherbone_cfg_out,
      cfg_slave_i => etherbone_cfg_in,
      master_o    => etherbone_wb_out,
      master_i    => etherbone_wb_in);

  masterbar: xwb_crossbar
    generic map(
      g_num_masters => 2,
      g_num_slaves  => 1,
      g_registered  => false,
      g_address     => (0 => x"00000000"),
      g_mask        => (0 => x"00000000"))
    port map(
      clk_sys_i => clk_sys,
      rst_n_i   => local_reset_n,
      slave_i   => slave_i,
      slave_o   => slave_o,
      master_i  => master_i,
      master_o  => master_o);

  cmp_l_clk_buf: IBUFDS
    generic map(
      CAPACITANCE      => "DONT_CARE",
      DIFF_TERM        => false,
      IBUF_DELAY_VALUE => "0",
      IBUF_LOW_PWR     => true,
      IFD_DELAY_VALUE  => "AUTO",
      IOSTANDARD       => "DEFAULT",
      DQS_BIAS         => "FALSE")
    port map(
      O  => l_clk,
      I  => L_CLKp,
      IB => L_CLKn);

  U_WR_CORE: xwr_core
    generic map(
      g_simulation                => 0,
      g_phys_uart                 => true,
      g_virtual_uart              => true,
      g_with_external_clock_input => true,
      g_aux_clks                  => 0,
      g_ep_rxbuf_size             => 1024,
      g_tx_runt_padding           => true,
      g_dpram_initf               => "wrc.ram",
      g_dpram_size                => 131072/4,
      g_interface_mode            => PIPELINED,
      g_address_granularity       => BYTE,
      g_aux_sdb                   => c_etherbone_sdb,
      g_softpll_enable_debugger   => false,
      g_vuart_fifo_size           => 1024,
      g_pcs_16bit                 => false)
    port map(
      clk_sys_i            => clk_sys,
      clk_dmtd_i           => clk_dmtd,
      clk_ref_i            => clk_125m_pllref,
      clk_aux_i            => (OTHERS => '0'),
      clk_ext_mul_i        => clk_ext_mul,
      clk_ext_mul_locked_i => clk_ext_mul_locked,
      clk_ext_stopped_i    => clk_in_stopped_o,
      clk_ext_rst_o        => clk_ext_rst_o,
      clk_ext_i            => clk_ext,
      pps_ext_i            => dio_in(3),
      rst_n_i              => local_reset_n,
      dac_hpll_load_p1_o   => dac_hpll_load_p1,
      dac_hpll_data_o      => dac_hpll_data,
      dac_dpll_load_p1_o   => dac_dpll_load_p1,
      dac_dpll_data_o      => dac_dpll_data,
      phy_ref_clk_i        => clk_125m_pllref,
      phy_tx_data_o        => phy_tx_data,
      phy_tx_k_o           => phy_tx_k,
      phy_tx_disparity_i   => phy_tx_disparity,
      phy_tx_enc_err_i     => phy_tx_enc_err,
      phy_rx_data_i        => phy_rx_data,
      phy_rx_rbclk_i       => phy_rx_rbclk,
      phy_rx_k_i           => phy_rx_k,
      phy_rx_enc_err_i     => phy_rx_enc_err,
      phy_rx_bitslide_i    => phy_rx_bitslide,
      phy_rst_o            => phy_rst,
      phy_rdy_i            => phy_rdy,
      phy_loopen_o         => phy_loopen,
      phy_loopen_vec_o     => phy_loopen_vec,
      phy_tx_prbs_sel_o    => phy_prbs_sel,
      phy_sfp_tx_fault_i   => sfp_tx_fault_i,
      phy_sfp_los_i        => sfp_los_i,
      phy_sfp_tx_disable_o => sfp_tx_disable_o,
      led_act_o            => LED_RED,
      led_link_o           => LED_GREEN,
      scl_o                => wrc_scl_o,
      scl_i                => wrc_scl_i,
      sda_o                => wrc_sda_o,
      sda_i                => wrc_sda_i,
      sfp_scl_o            => sfp_scl_o,
      sfp_scl_i            => sfp_scl_i,
      sfp_sda_o            => sfp_sda_o,
      sfp_sda_i            => sfp_sda_i,
      sfp_det_i            => sfp_mod_def0_b,
      btn1_i               => button1_i,
      btn2_i               => button2_i,
      spi_sclk_o           => spi_sclk_o,
      spi_ncs_o            => spi_ncs_o,
      spi_mosi_o           => spi_mosi_o,
      spi_miso_i           => spi_miso_i,
      uart_rxd_i           => uart_rxd_i,
      uart_txd_o           => uart_txd_o,
      owr_pwren_o          => open,
      owr_en_o             => owr_en,
      owr_i                => owr_i,
      slave_i              => wrc_slave_i,
      slave_o              => wrc_slave_o,
      aux_master_o         => etherbone_cfg_in,
      aux_master_i         => etherbone_cfg_out,
      wrf_src_o            => etherbone_snk_in,
      wrf_src_i            => etherbone_snk_out,
      wrf_snk_o            => etherbone_src_in,
      wrf_snk_i            => etherbone_src_out,
      timestamps_o         => open,
      timestamps_ack_i     => '1',
      txts_o               => dio_out(2),
      rxts_o               => dio_out(1),
      fc_tx_pause_req_i    => '0',
      fc_tx_pause_delay_i  => x"0000",
      fc_tx_pause_ready_o  => open,
      tm_link_up_o         => open,
      tm_dac_value_o       => open,
      tm_dac_wr_o          => open,
      tm_clk_aux_lock_en_i => open,
      tm_clk_aux_locked_o  => open,
      tm_time_valid_o      => open,
      tm_tai_o             => open,
      tm_cycles_o          => open,
      pps_p_o              => pps,
      pps_led_o            => pps_led,
      dio_o                => open,
      rst_aux_n_o          => etherbone_rst_n,
      link_ok_o            => open);

    fpga_scl_b <= '0' when wrc_scl_o = '0' else 'Z';
    fpga_sda_b <= '0' when wrc_sda_o = '0' else 'Z';
    wrc_scl_i  <= fpga_scl_b;
    wrc_sda_i  <= fpga_sda_b;


    sfp_mod_def1_b <= '0' when sfp_scl_o = '0' else 'Z';
    sfp_mod_def2_b <= '0' when sfp_sda_o = '0' else 'Z';
    sfp_scl_i      <= sfp_mod_def1_b;
    sfp_sda_i      <= sfp_mod_def2_b;


    thermo_id <= '0' when owr_en(0) = '1' else 'Z';
    owr_i(0)  <= thermo_id;

    dio_onewire_b <= '0' when owr_en(1) = '1' else 'Z';
    owr_i(1)      <= dio_onewire_b;
    dio_oe_n_o(0)          <= '0';
    dio_oe_n_o(2 downto 1) <= (others => '0');
    dio_oe_n_o(3)          <= '1';        -- for external 1-PPS
    dio_oe_n_o(4)          <= '1';        -- for external 10MHz clock

    dio_term_en_o <= (others => '0');

    dio_sdn_ck_n_o <= '1';
    dio_sdn_n_o    <= '1';

  --  sfp_tx_disable_o <= '0';
    ------------------------------------------------------------------------------
    -- Active high reset
    ------------------------------------------------------------------------------
    rst <= not(L_RST_N);
        genum_wb_out.adr(1  downto  0) <= (others => '0');
        genum_wb_out.adr(18 downto  2) <= wb_adr(16 downto 0);
        genum_wb_out.adr(31 downto 19) <= (others => '0');
        genum_wb_out.dat               <= csr_dat_o;
        genum_wb_out.sel               <= csr_sel_o;
        genum_wb_out.stb               <= csr_stb_o;
        genum_wb_out.we                <= csr_we_o;
        genum_wb_out.cyc               <= csr_cyc_o;
        csr_dat_i                      <= genum_wb_in.dat;
        genum_csr_ack_i                <= genum_wb_in.ack or genum_wb_in.err;
        csr_stall_i                    <= genum_wb_in.stall;
        csr_err_i                      <= '0';
        csr_rty_i                      <= '0';
        csr_int_i                      <= '0';
    dma_reg_adr_i <= x"00000000";
    dma_reg_dat_i <= x"00000000";
    dma_reg_sel_i <= x"0";
    dma_reg_stb_i <= '0';
    dma_reg_we_i  <= '0';
    dma_reg_cyc_i <= '0';
    --dma_reg_dat_o   => dma_reg_dat_i,
    --dma_reg_ack_o   => dma_reg_ack,
    --dma_reg_stall_o => dma_reg_stall
    --dma_adr_o   => dma_adr,
    --dma_dat_o   => dma_dat_o,
    --dma_sel_o   => dma_sel,
    --dma_stb_o   => dma_stb,
    --dma_we_o    => dma_we,
    --dma_cyc_o   => dma_cyc,
    dma_dat_i   <= x"00000000";
    dma_ack_i   <= '0';
    dma_stall_i <= '0';
    dma_err_i   <= '0';
    dma_rty_i   <= '0';
    dma_int_i   <= '0';

  pr1: process (clk_sys, rst) is		-- EASE/HDL sens.list
  begin
      if rising_edge(clk_sys) then
        led_divider <= led_divider + 1;
      end if;
  end process pr1 ;
end architecture rtl ; -- of spec_top

