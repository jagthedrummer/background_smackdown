Batches = {};
Batches.show = {};

Batches.show.init = function(){
  //Batches.buildBoxChart(job_data,'runtime','#box_chart',1000);
  //Batches.buildBoxChart(sys_data,'load_1','#load_chart',1);
  //Batches.buildBoxChart(sys_data,'user_cpu','#user_cpu_chart',1);
  //Batches.buildBoxChart(sys_data,'sys_cpu','#sys_cpu_chart',1);

  var lineData = [];
  lineData.push(Batches.extractLine(sys_data,'cpu',function(d){return d['sys_cpu']+d['user_cpu']}));
  lineData.push(Batches.extractLine(sys_data,'user',function(d){return d['user_cpu']}));
  lineData.push(Batches.extractLine(sys_data,'sys',function(d){return d['sys_cpu']}));
  //
  Batches.buildLineChart(lineData,'#user_cpu_line');


  lineData = [];
  lineData.push(Batches.extractLine(sys_data,'load',function(d){return d['load_1']}));
  Batches.buildLineChart(lineData,'#load_line');

  var scatterData = [];
  //scatterData = randomData(1,2000);
  
  scatterData.push( Batches.extractScatter(job_data,'started','runtime','started_at',0) );
  //scatterData.push( Batches.extractScatter(job_data,'ended','runtime','ended_at',1) );
  //
  console.log('scatterData');
  console.log(scatterData);
  Batches.addScatter(scatterData);
  
}


Batches.extractScatter = function(orig_data,label,value,date_field,series){
  var data = {
    key : label,
    values : []
  };

  var base_time = Date.parse(orig_data[0][date_field]);

  $.each(orig_data,function(i,d){
    var x = Date.parse(d[date_field]) - base_time;
    var y = d[value];
    var size = 0.1;
    var d2 = {x:x , y:y, series:series, size:size};
    //console.log(d2);
    data.values.push(d2);
  });

  console.log(data);
  return data;
}



Batches.addScatter = function(data){

  nv.addGraph(function() {
    var chart = nv.models.scatterChart()
                  .showDistX(true)
                  .showDistY(true)
                  .color(d3.scale.category10().range());

    chart.xAxis.tickFormat(d3.format('.02f'))
    chart.yAxis.tickFormat(d3.format('.02f'))

    d3.select('#job_scatter svg')
        .datum(data)
      .transition().duration(500)
        .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });

}


  function randomData(groups, points) { //# groups,# points per group
    var data = [],
        shapes = ['circle', 'cross', 'triangle-up', 'triangle-down', 'diamond', 'square'],
        random = d3.random.normal();

    for (i = 0; i < groups; i++) {
      data.push({
        key: 'Group ' + i,
        values: []
     });

      for (j = 0; j < points; j++) {
        data[i].values.push({
          x: random()
        , y: random()
        , size: Math.random()
        //, shape: shapes[j % 6]
        });
      }
    }
    console.log("===============");
    console.log(data);
    return data;
  }



Batches.extractLine = function(orig_data,key,valueFunc,color){
  
  var base_time = Date.parse(orig_data[0]['created_at']);

  var data = {
    values : [],
    key : key
  };

  $.each(orig_data,function(i,d){
    var x = Date.parse(d['created_at']) - base_time;
    var y = valueFunc(d);
    var d2 = {x:x , y:y};
    //console.log(d2);
    data.values.push(d2);
  });

  console.log(data);
  return data;
}

Batches.buildLineChart = function(data, selector){
  

  console.log("-----------------");
  console.log(data);


  nv.addGraph(function() {  
    var chart = nv.models.lineChart();

    chart.xAxis
        .axisLabel('Time (ms)')
        .tickFormat(d3.format(',r'));

    chart.yAxis
        .axisLabel('CPU %')
        .tickFormat(d3.format('.02f'));

    d3.select(selector + ' svg')
        .datum(data)
      .transition().duration(500)
        .call(chart);

    //nv.utils.windowResize(function() { d3.select(selector + ' svg').call(chart) });

    return chart;
  }); 



}


Batches.buildBoxChart = function(orig_data,value,selector,multiplier){
  console.log(orig_data);

  var margin = {top: 10, right: 50, bottom: 20, left: 50},
      width = 120 - margin.left - margin.right,
      height = 300 - margin.top - margin.bottom;

  var min = Infinity,
      max = -Infinity;

  var chart = d3.box()
      .whiskers(iqr(1.5))
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
