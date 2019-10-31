library verilog;
use verilog.vl_types.all;
entity bcd_converter_vlg_sample_tst is
    port(
        Bin             : in     vl_logic_vector(7 downto 0);
        sampler_tx      : out    vl_logic
    );
end bcd_converter_vlg_sample_tst;
