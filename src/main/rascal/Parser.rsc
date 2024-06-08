module Parser

import IO;
import ParseTree;
import Grammar;
import vis::Text;

void main() {

    str input = readFile(|FileLocation|); //Change to the location of the file you want to parse

     //Example of location |file:///C:/Users/javie/OneDrive/Escritorio/PG/Proyectos/writefile/src/main/rascal/output.txt|   

    Program p = parse(#Program, input, allowAmbiguity=true);

    println(p);

    pe = prettyTree([Program] input);
    println(pe);
}

