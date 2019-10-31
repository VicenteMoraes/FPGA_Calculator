library verilog;
use verilog.vl_types.all;
entity bcd_converter is
    port(
        D               : out    vl_logic_vector(9 downto 0);
        Bin             : in     vl_logic_vector(7 downto 0)
    );
end bcd_converter;
