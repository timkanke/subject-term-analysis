# DPLA Subject Term Analysis
This project is a subject term analysis method for DPLA metadata using a collection of scripts.

**Overview**

This method has three primary stages:

- Obtain
- Scrub
- Explore

Each of these stages have their own folder and the directions can be found in a markdown file. In order to use this method download this repostiory. Next, create two additional folders named 'data' and 'vocab'. The data folder will contain DPLA metadata files for the obtain, scrub, and explore stages. The vocab folder will contain controlled vocabularies using the obtain and scrub stages.

**Software requirements**

This process has been developed with Linux and will most likely need refinement to work on other operating systems. Additional required software included:
* Apache Spark
* Apache Jena ARQ (https://jena.apache.org/documentation/query/index.html)
* dos2unix (https://sourceforge.net/projects/dos2unix/)
* python 3
* pandas

