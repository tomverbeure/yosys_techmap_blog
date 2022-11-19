
This project contains the example Verilog source code and Yosys graph generation scripts for
my [Logic Primitive Transformations with Yosys Techmap blog post](https://tomverbeure.github.io/2022/11/18/Primitive-Transformations-with-Yosys-Techmap.html).

To run the scripts:

* Install [Yosys](https://github.com/YosysHQ/yosys).
* Run:

    ```sh
yosys -s mul.yosys
yosys -s add_reduce.yosys
    ```

