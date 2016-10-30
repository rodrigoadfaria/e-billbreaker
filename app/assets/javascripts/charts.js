//google.charts.load('current', {'packages':['line']});
//google.charts.setOnLoadCallback(drawChart);

$(document).ready(function() {
    updateChart();
    setInterval(updateChart, 5000);
});

function updateChart() {
    $.ajax({
        url: 'https://edx-ruby-rails-rodrigoadfaria-1.c9users.io/sensor_values/',
        complete : function() {
            // do nothing
        },
        success: function(data) {
            drawChart(data)
        }
    });     
};

function drawChart(sensor_values) {
  var data = new google.visualization.DataTable();
  data.addColumn('date', 'Dia');
  
  var resources = sensor_values.resources;
  for (i = 0; i < resources.length; i++) {
      var resource = resources[i];
      data.addColumn('number', resource.sensor_name);
      
      for (j = 0; j < resource.values.length; j++) {
          var s_value = resource.values[j];
          console.log(s_value);
          data.addRows([[new Date(s_value.date),  s_value.value]]);
      }
  }

  var options = {
    chart: {
      title: 'Leitor de Consumo',
      subtitle: 'medida em Watt'
    },
    width: 900,
    height: 500,
    axes: {
      x: {
        0: {side: 'top'}
      }
    }
  };

  var chart = new google.charts.Line(document.getElementById('chart_div'));

  chart.draw(data, options);
}