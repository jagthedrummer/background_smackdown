Batches = {};
Batches.show = {};

Batches.show.init = function(){
  Batches.buildBoxChart(job_data,'runtime','#box_chart',1000);
}


Batches.buildBoxChart = function(orig_data,value,selector,multiplier){
  console.log(orig_data);

  var margin = {top: 10, right: 50, bottom: 20, left: 50},
      width = 120 - margin.left - margin.right,
      height = 300 - margin.top - margin.bottom;

  var min = Infinity,
      max = -Infinity;

  var chart = d3.box()
      .whiskers(iqr(0))
      .width(width)
      .height(height);
  data = [];
  $.each(orig_data,function(i,d){
    var v = d[value] * multiplier;
    data.push(v)
    if (v > max) max = v;
    if (v < min) min = v;
  })
  data = [data];
  console.log(data);
  console.log(min);
  console.log(max);
  chart.domain([min, max]);

  var vis = d3.select(selector).selectAll("svg")
      .data(data)
    .enter().append("svg")
      .attr("class", "box")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.bottom + margin.top)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
      .call(chart);
  
  // Returns a function to compute the interquartile range.
  function iqr(k) {
    return function(d, i) {
      var q1 = d.quartiles[0],
          q3 = d.quartiles[2],
          iqr = (q3 - q1) * k,
          i = -1,
          j = d.length;
      while (d[++i] < q1 - iqr);
      while (d[--j] > q3 + iqr);
      console.log([i,j]);
      return [i, j];
    };
  }

}
