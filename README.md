<h1 align="center">
    kaldi-grammar-compiler &middot; Support for Grammar-Based Language Models in Kaldi
</h1>

__kaldi-grammar-compiler__ is a minimal tool that helps transforming [Regulus Lite](https://arxiv.org/abs/1510.01942) regular grammars into compiled Finite State Transducers (FSTs). This thus makes them readable as language models (G.fst) in Kaldi so that they can be used as part of an Automatic Speech Recognition (ASR) system. By doing so, we intended to provide a straight-forward tool for adding grammar-based language models into the Kaldi Speech Technology Toolkit.

The tool that we present is built from a collection of programs written in Bash, Perl and Python using standard libraries and the C++ OpenFST library. 

<p align="center">
    <a href="https://github.com/lormaechea/kaldi-grammar-compiler/archive/refs/heads/main.zip">
        <img src="https://img.shields.io/badge/kaldi--grammar--compiler%201.0-DOWNLOAD-brightgreen?style=for-the-badge&logo=appveyor">
    </a>
</p>


## Installation requirements

In order to properly run this tool, it is necessary to previously install the latest version of [Kaldi](https://github.com/kaldi-asr/kaldi).

    $ git clone https://github.com/kaldi-asr/kaldi.git .

You will then need to fork/clone the ***kaldi-grammar-compiler*** into your local/remote machine:

    $ git clone https://github.com/lormaechea/kaldi-grammar-compiler.git .


## Usage

Once you have installed the required components and cloned the __kaldi-grammar-compiler__ repository, you will need to export Kaldi path by using the `source`  command and editing (if necessary) the `path.sh` script made available in the main directory: 

    $ source path.sh

As for the grammar generation, it results from the execution of the **genGrammar.sh** script, which will take a source format grammar file as an input and will transform it into a G.fst binary file. Three positional paramaters must be specified:

| ***Option*** | ***Description*** |
| ---- | --- |
| `(-g\|--grammar)` | Where the input Regulus Lite grammar file needs to be defined. |
| `(-s\|--stage)` | Where the stage process is set.  |
| `(-d\|--draw_graph)` | Where you can specify if you also want to get a visual .png representation of the resulting `G.fst` graph. <br> __Note:__ this is highly unrecommended for very comprehensive grammars as it can overload the RAM memory). |

The execution is as follows:

    $ bash genGrammar.sh --grammar=<input_file> --stage=<stage> --draw_graph=<yes/no>


## Stage [0] | Data preparation and normalization

Before proceeding to the compilation of the grammars, a preparation and normalization process is firstly required. In order to do so, `prepareGrammar.pl` will be called by our main script. It will:

- First take as input a source grammar written in the Regulus Lite formalism and split the __main grammar__ (containing a set of phrases which represent some specific discourse) from the __sub-grammars__ (corresponding to word classes represented by non-terminal symbols). 
- And then normalize the data so that it can be properly converted into FSTs in the next phase. 

From which we will get the subsequent files as output (let's assume that `demo.txt` is the `<INPUT_FILE>`):

- `demo_main.txt` &rarr; Main grammar.

- `demo_sub.txt` &rarr; Sub-grammars.

- `demo_main_norm.txt` &rarr; Normalized main grammar.

- `demo_sub_norm.txt `&rarr; Normalized sub-grammars.

- `newWords.txt` &rarr; This is a file that will add to a pre-existing lexicon the absent non-terminal symbols and the Out-Of-Vocabulary (OOV) forms found in the grammar given in input. It will assign an identifier to each unit. 


## Stages [1-3] | Grammar compilation with OpenFST

Once the normalized files have been produced, we can move on to the compilation process. The **`genGrammar.sh`** script will transform the input files into binary Finite State Transducers (FSTs). To do so, it will follow 3 steps:

| ***Steps*** | ***Description*** |
| --- | --- |
| `[--stage=1]` | First it will compile the main grammar. |
| `[--stage=2]` | It will subsequently compile every sub-grammar word class.  |
| `[--stage=3]` | Finally it will replace the non terminal symbols found in the main grammar by its corresponding terminals (found on the sub-grammars). |



## Resulting G.fst

Once the pipeline process is achieved, a folder containing the resulting grammar, `G.fst`, will be created. It can now be used as a language model in your Kaldi ASR experiments!



## License

Licensed under the [Apache 2.0 License](https://github.com/lormaechea/kaldi_grammar_compiler/blob/main/LICENSE).
