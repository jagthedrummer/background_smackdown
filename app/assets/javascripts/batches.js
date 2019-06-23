Batches = {};
Batches.show = {};
Batches.index = {};


Batches.index.init = function(){

  var barData = Batches.extractHorizBarData(batchData,'mean');
  Batches.addHorizBar(barData,'#mean');

  var barData = Batches.extractHorizBarData(batchData,'wall_time');
  Batches.addHorizBar(barData,'#wall_time');

  var barData = Batches.extractHorizBarData(batchData,'run_time');
  Batches.addHorizBar(barData,'#run_time');

  var barData = Batches.extractHorizBarData(batchData,'percentile95');
  Batches.addHorizBar(barData,'#percentile95');

  /*
  var barData = Batches.extractHorizBarData(batchData,'median');
  Batches.addHorizBar(barData,'#median');

  var barData = Batches.extractHorizBarData(batchData,'standard_deviation');
  Batches.addHorizBar(barData,'#standard_deviation');
  */
  var scatterData = [];
  $.each(batchData,function(i,d){
    var base_time = Date.parse(d.system_stats[0]['created_at']);
    console.log("base_time " + base_time);
    var name = d.background_type + ' ' + d.worker_count + '/' + d.thread_count;
    scatterData.push( Batches.extractScatter(d.jobs,name,'runtime','started_at',0,base_time) );
  });
  Batches.addScatter(scatterData);

  var lineData = [];
  $.each(batchData,function(i,d){
    var base_time = Date.parse(d.system_stats[0]['created_at']);
    console.log("base_time " + base_time);
    var name = d.background_type + ' ' + d.worker_count + '/' + d.thread_count;
    lineData.push(Batches.extractLine(d.system_stats,name,function(d){return d['sys_cpu']+d['user_cpu']},base_time));
  });
  Batches.buildLineChart(lineData,'#user_cpu_line');

  /*
  lineData = [];
  $.each(batchData,function(i,d){
    var base_time = Date.parse(d.system_stats[0]['created_at']);
    console.log("base_time " + base_time);
    var name = d.background_type + ' ' + d.worker_count + '/' + d.thread_count;
    lineData.push(Batches.extractLine(d.system_stats,name,function(d){return d['load_1']},base_time));
  });
  Batches.buildLineChart(lineData,'#load_line');
  */

  var boxData = Batches.extractBox(batchData);
  Batches.buildMultiBox(boxData);
}

Batches.extractHorizBarData = function(batchData,value){
  var resqueData = [];
  var sidekiqData = [];
  $.each(batchData,function(i,d){
    var bd = {
      label : d3.max([d.worker_count, d.thread_count]),
      value : d[value]
    };
    if(d.background_type == "Resque"){
      resqueData.push(bd);
    }else{
      sidekiqData.push(bd);
    }
  });

  rData = [
    { key : "Resque",
      values : resqueData
    },
    { key : "Sidekiq",
      values : sidekiqData
    }
  ];
  return rData;

}

Batches.addHorizBar = function(data,selector){
  nv.addGraph(function() {
    var chart = nv.models.multiBarHorizontalChart()
        .x(function(d) { return d.label })
        .y(function(d) { return d.value })
       .margin({top: 30, right: 20, bottom: 50, left: 20})
        .showValues(true)
        .tooltips(false)
        .showControls(false);

    chart.yAxis
        .tickFormat(d3.format(',.2f'));

    d3.select(selector + ' svg')
        .datum(data)
      .transition().duration(500)
        .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
}

Batches.show.init = function(){
  //Batches.buildBoxChart(job_data,'runtime','#box_chart',1000);
  //Batches.buildBoxChart(sys_data,'load_1','#load_chart',1);
  //Batches.buildBoxChart(sys_data,'user_cpu','#user_cpu_chart',1);
  //Batches.buildBoxChart(sys_data,'sys_cpu','#sys_cpu_chart',1);

  var base_time = Date.parse(sys_data[0]['created_at']);

  var lineData = [];
  lineData.push(Batches.extractLine(sys_data,'cpu',function(d){return d['sys_cpu']+d['user_cpu']},base_time));
  lineData.push(Batches.extractLine(sys_data,'user',function(d){return d['user_cpu']},base_time));
  lineData.push(Batches.extractLine(sys_data,'sys',function(d){return d['sys_cpu']},base_time));
  //
  Batches.buildLineChart(lineData,'#user_cpu_line');


  lineData = [];
  lineData.push(Batches.extractLine(sys_data,'load',function(d){return d['load_1']},base_time));
  Batches.buildLineChart(lineData,'#load_line');

  var scatterData = [];
  
  scatterData.push( Batches.extractScatter(job_data,'started','runtime','started_at',0,base_time) );
  //scatterData.push( Batches.extractScatter(job_data,'ended','runtime','ended_at',1) );
  //
  console.log('scatterData');
  console.log(scatterData);
  Batches.addScatter(scatterData);
  
}


Batches.extractScatter = function(orig_data,label,value,date_field,series,base_time){
  var data = {
    key : label,
    values : []
  };

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



Batches.extractLine = function(orig_data,key,valueFunc,base_time){
  
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
    var chart = nv.models.lineChart()
                  .color(d3.scale.category10().range());

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


Batches.extractBox = function(batch_data,series){
  var data = [];
  var min = Infinity,
      max = -Infinity;

  batch_data.forEach(function(batch,bi){
    console.log('bi = ' + bi);
    batch.jobs.forEach(function(x,i) {
      var e = Math.floor(bi),
          r = Math.floor(i),
          s = x.runtime,
          d = data[e];
      if (!d) d = data[e] = [s];
      else d.push(s);
      if (s > max) max = s;
      if (s < min) min = s;
    });
  });
    
  var real_data = { values : data, min : min, max : max };
  console.log(real_data);
  return real_data;
}

Batches.buildMultiBox = function(data){
  var margin = {top: 10, right: 50, bottom: 20, left: 50},
      width = 120 - margin.left - margin.right,
      height = 300 - margin.top - margin.bottom;

  var chart = d3.box()
      .whiskers(iqr(1.5))
      .width(width)
      .height(height);

    chart.domain([data.min, data.max]);

    var svg = d3.select("#box_chart").selectAll("svg")
        .data(data.values)
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
      return [i, j];
    };
  }
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
