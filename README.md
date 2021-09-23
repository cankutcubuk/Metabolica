# Metabolica
A systems biology approach to prioritize METABOLItes in CAncer.

Here you can find the R script of the Metabolica tool and some toy examples of its usage. 
Metabolica is descendant of our previous tool Metabolizer [[1](http://cancerres.aacrjournals.org/content/78/21/6059), [2](https://www.nature.com/articles/s41540-019-0087-2), [3](http://metabolizer.babelomics.org/), [4](https://github.com/babelomics/metabolizer)] which was limited with the KEGG metabolic module activities.
Metabolica extends its application to whole metabolism. Dissects KEGG metabolic pathways into subpathways and calculates their activities which account for metabolite abundances.

Metabolica uses transcriptomic and/or genomic data as input to predict reaction activities and then propagates metabolic flux over metabolic hypergraph that accounts for the production of a metabolite. Metabolica returns individual-level results that can be used in wide-range of posterior analysis to explain state-of-the-art cell biology and complex cellular mechanisms of diseases.



<!DOCTYPE html>
<html>
<body>
<style>
.myClass {
  color: white;
  background-color: DodgerBlue;
  padding: 20px;
  text-align: center;
  margin: 10px;
}
</style>

<h1>The template Element</h1>

<p>This example fills the web page with one new div element for each item in an array.</p>
<p>The HTML code of each div element is inside the template element.</p>

<p>Click the button below to display the hidden content from the template element.</p>

<button onclick="showContent()">Show hidden content</button>

<template>
  <div class="myClass">I like: </div>
</template>

<script>
var myArr = ["Audi", "BMW", "Ford", "Honda", "Jaguar", "Nissan"];

function showContent() {
  var temp, item, a, i;
  temp = document.getElementsByTagName("template")[0];
  //get the div element from the template:
  item = temp.content.querySelector("div");
  //for each item in the array:
  for (i = 0; i < myArr.length; i++) {
    //Create a new node, based on the template:
    a = document.importNode(item, true);
    //Add data from the array:
    a.textContent += myArr[i];
    //append the new node wherever you like:
    document.body.appendChild(a);
  }
}
</script>

</body>
</html>
