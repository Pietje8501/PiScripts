var w = 500;
var h = 250;
var pad = 40;
var data = [];

$(document).ready(function (d) {
    d3.json("./data/chart.json", function (err, json) {
        if (err) {
            console.warn("Fout: " + error);
        }

        for (var i = 0; i < json.length; i++) {
            t = json[i].temp;
            c = json[i].cpu;
            d = json[i].date;
            data.push({temp: t, cpu: c, date: d});
        }
        drawGraph("cpu");
    });



    $('#temp').click(function (d) {
         drawGraph("temp");
    });
    $('#cpu').click(function (d) {
         drawGraph("cpu");
    });
});
function drawGraph(d) {
    var type = d;
    var minDate = getDate(data[0]);
    var maxDate = getDate(data[data.length - 1]);

    d3.select("svg").remove();

    var svg = d3.select("#statsimg")
        .append("svg")
        .attr("width", w + pad)
        .attr("height", h + pad);



    var x = d3.time.scale().domain([minDate, maxDate]).range([pad, w - pad * 2]);
    var y = d3.scale.linear().domain([
            d3.min(data,
                function (d) {
                    switch (type) {
                        case("temp"):
                            return d.temp;
                        case("cpu"):
                            return d.cpu;
                    }
                })*9/10,
            d3.max(data,
            function (d) {
                switch (type) {
                    case("temp"):
                        return d.temp;
                    case("cpu"):
                        return d.cpu;
                }
            })*10/9])
        .range([h - pad, pad]);

    var lineFn = d3.svg.line()
        .x(function (d) {
            return x(getDate(d));
        })
        .y(function (d) {
            switch (type) {
                case("temp"):
                    return y(d.temp);
                case("cpu"):
                    return y(d.cpu);
                default:
                    return y(d.temp)
            }
        });

    var yFormat = function(d){
    	switch(type){
            case("temp"):
                return d+"\xB0"+"C";
            case("cpu"):
                return d+"%";
    	    }
    };
    var xAxis = d3.svg.axis()
        .scale(x)
        .ticks(d3.time.hours, 6)
        .orient("bottom");
    var yAxis = d3.svg.axis()
        .scale(y)
	.tickFormat(function(d,i){return yFormat(d)})
        .orient("left")
        .ticks(5);

    var line = svg.append("path")
        .style("opacity", 0)
        .attr("d", lineFn(data))
        .transition()
        .duration(1500)
        .style("opacity", 1);
    svg.append("g")
        .attr("transform", "translate(0," + (h - pad) + ")")
        .call(xAxis);
    svg.append("g")
        .attr("transform", "translate(" + (pad) + ", 0)")
        .call(yAxis);
}


function getDate(d) {
    date = d.date.split(" ");
    datestr = Date.parse(date[2] + " " + date[1] + " " + date[date.length - 1] + " " + date[3]);
    return datestr;
}












