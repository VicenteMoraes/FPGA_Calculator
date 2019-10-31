library verilog;
use verilog.vl_types.all;
entity bcd_converter_vlg_check_tst is
    port(
        D               : in     vl_logic_vector(9 downto 0);
        sampler_rx      : in     vl_logic
    );
end bcd_converter_vlg_check_tst;
