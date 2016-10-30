
$(document).ready(function() {
    updateChart();
    setInterval(updateChart, 5000);
    
    $('#in').on("click", function() {
        updateChart('in');
    });

    $('#out').on("click", function() {
        updateChart('out');
    });
});

function updateChart(zoom) {
    var route = 'https://edx-ruby-rails-rodrigoadfaria-1.c9users.io/sensor_values/'
    if (zoom)
        route += '?zoom='+ zoom;

    $.ajax({
        url: route,
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
  data.addColumn('datetime', 'Horário');
  
  var resources = sensor_values.resources;
  for (i = 0; i < resources.length; i++) {
      var resource = resources[i];
      data.addColumn('number', resource.sensor_name);
      
      for (j = 0; j < resource.values.length; j++) {
          var s_value = resource.values[j];
          data.addRows([[new Date(s_value.date),  s_value.value]]);
      }
  }
  

  var options = {
    chart: {
      title: 'Leitor de Consumo',
      subtitle: 'Medida em Watt'
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