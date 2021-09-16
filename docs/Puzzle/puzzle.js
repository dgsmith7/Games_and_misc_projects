var numberOfMoves = 0;
var bestScore = 9999;
var blankLocation = 15;
var xLim = 335;
var wide = parseInt(document.getElementById("arena").clientWidth);
var yLim = 335;
var tileSize = 80;
var labels = ["Moves", "Best", "Reset"];
var tile = function(p, t, f, x, y) {
    this.place = p;
    this.type = t;
    this.face = f;
    this.x = x;
    this.y = y;
}
var workBoard = [];
var solvedBoard = [];
var buttonWidth = (xLim / 3) - 10;
var buttonHeight = buttonWidth;

function initBoards() { // set solution and workboards and blankLocation to solved position 
    function getTileType(i) {
        switch (i) {
            case (1):
                t = "UL";
                break;
            case (2):
                t = "T";
                break;
            case (3):
                t = "T";
                break;
            case (4):
                t = "UR";
                break;
            case (5):
                t = "L";
                break;
            case (9):
                t = "L";
                break;
            case (6):
                t = "C";
                break;
            case (7):
                t = "C";
                break;
            case (10):
                t = "C";
                break;
            case (11):
                t = "C";
                break;
            case (8):
                t = "R";
                break;
            case (12):
                t = "R";
                break;
            case (13):
                t = "LL";
                break;
            case (14):
                t = "B";
                break;
            case (15):
                t = "B";
                break;
            case (0):
                t = "LR";
                break;
        }
        return t;
    }
    solvedBoard[15] = new tile(15, getTileType(0), 0, ((xLim / 4) * ((15) % 4)) + ((wide - xLim) / 2), (((yLim / 4) * Math.ceil(((16) / 4))) - (yLim / 4)));
    workBoard[15] = new tile(15, getTileType(0), 0, ((xLim / 4) * ((15) % 4)) + ((wide - xLim) / 2), (((yLim / 4) * Math.ceil(((16) / 4))) - (yLim / 4)));
    blankLocation = 15;
    for (var i = 1; i < 16; i++) {
        solvedBoard[i - 1] = new tile(i - 1, getTileType(i), i, ((xLim / 4) * ((i - 1) % 4)) + ((wide - xLim) / 2), (((yLim / 4) * Math.ceil(((i) / 4))) - (yLim / 4)));
        workBoard[i - 1] = new tile(i - 1, getTileType(i), i, ((xLim / 4) * ((i - 1) % 4)) + ((wide - xLim) / 2), (((yLim / 4) * Math.ceil(((i) / 4))) - (yLim / 4)));

    }
}

function mixWorkBoard() { // shufles tiles on workboard
    // for test board
    /*
    for (i = 0; i < 16; i++) {
    	workBoard[i].face = i + 1;
    }
    workBoard[14].face = 0;
    workBoard[15].face = 15;
    blankLocation = 14;
    */

    // for real mixed-up board
    var temp = new tile(0, 0, 0, 0, 0);
    while (checkSolved() == true) {
        for (i = 0; i < 16; i++) {
            swapper = parseInt(Math.random() * 16);
            temp = workBoard[i].face;
            workBoard[i].face = workBoard[swapper].face;
            workBoard[swapper].face = temp;
        }
    }
    for (i = 0; i < 16; i++) { // set new blankLocation
        if (workBoard[i].face == 0) blankLocation = i;
    }
}

function checkSolved() { // returns true if solved
    var flag = true;
    for (i = 0; i < 16; i++) {
        if (workBoard[i].face != solvedBoard[i].face) {
            flag = false;
        }
    }
    return flag;
}

function adjustWorkBoard(i, j) { // swaps two tiles
    var temp = new tile(0, 0, 0, 0, 0);
    temp.face = workBoard[i].face;
    workBoard[i].face = workBoard[j].face;
    workBoard[j].face = temp.face;
    blankLocation = i;
    showWorkBoard();
}

function resetGame() { // setup for a new game
    initBoards();
    initButtons();
    generateAndBindTiles();
    mixWorkBoard();
    numberOfMoves = 0;
    d3.select("body").select("#arena").select("svg").selectAll("rect")
        .style("fill", "blue")
        .attr("pointer-events", "auto");
    showWorkBoard();
    showButtons();
}

function getBestScore() { // resets best score 
    if (numberOfMoves < bestScore) {
        bestScore = numberOfMoves;
    }
    return bestScore;
}

function checkValidMove(clicked) { // return true if clicked tile has adjacent blank
    var valid = false;
    switch (clicked.type) {
        case ("UL"):
            if ((blankLocation == (clicked.place + 1)) ||
                (blankLocation == (clicked.place + 4))) valid = true;
            break;
        case ("T"):
            if ((blankLocation == (clicked.place + 1)) ||
                (blankLocation == (clicked.place - 1)) ||
                (blankLocation == (clicked.place + 4))) valid = true;
            break;
        case ("UR"):
            if ((blankLocation == (clicked.place - 1)) ||
                (blankLocation == (clicked.place + 4))) valid = true;
            break;
        case ("L"):
            if ((blankLocation == (clicked.place - 4)) ||
                (blankLocation == (clicked.place + 1)) ||
                (blankLocation == (clicked.place + 4))) valid = true;
            break;
        case ("C"):
            if ((blankLocation == (clicked.place - 4)) ||
                (blankLocation == (clicked.place - 1)) ||
                (blankLocation == (clicked.place + 1)) ||
                (blankLocation == (clicked.place + 4))) valid = true;
            break;
        case ("R"):
            if ((blankLocation == (clicked.place - 4)) ||
                (blankLocation == (clicked.place - 1)) ||
                (blankLocation == (clicked.place + 4))) valid = true;
            break;
        case ("LL"):
            if ((blankLocation == (clicked.place + 1)) ||
                (blankLocation == (clicked.place - 4))) valid = true;
            break;
        case ("B"):
            if ((blankLocation == (clicked.place - 1)) ||
                (blankLocation == (clicked.place + 1)) ||
                (blankLocation == (clicked.place - 4))) valid = true;
            break;
        case ("LR"):
            if ((blankLocation == (clicked.place - 1)) ||
                (blankLocation == (clicked.place - 4))) valid = true;
            break;
    }
    return valid;
}

function generateAndBindTiles() {
    d3.select("body").select("#arena").select("svg").selectAll("rect")
        .data(workBoard)
        .enter()
        .append("rect")
        .attr("id", function(d, i) {
            return "tile" + i;
        })
        .attr("x", function(d, i) {
            return d.x;
        })
        .attr("y", function(d, i) {
            return d.y;
        })
        .attr("width", tileSize)
        .attr("height", tileSize)
        .attr("rx", 7)
        .attr("ry", 7)
        .style("fill", function(d, i) {
            if (d.face == 0) return "white";
            if (d.face > 0) return "blue";
        })
        .style("fill-opacity", 0.5)
        .on("click", function(d, i) {
            processMove(d, i);
        });
    d3.select("body").select("#arena").select("svg").selectAll("text")
        .data(workBoard)
        .enter()
        .append("text")
        .attr("x", function(d, i) {
            return d.x + (tileSize / 2);
        })
        .attr("y", function(d, i) {
            return d.y + (tileSize / 1.4);
        })
        .attr("font-family", "Architects Daughter")
        .attr("font-size", "3em")
        .style("fill", "black")
        .style("text-anchor", "middle")
        .text(function(d) {
            if (d.face == 0) return "";
            if (d.face > 0) return d.face;
        })
        .on("click", function(d, i) {
            processMove(d, i);
        });
}

function showWorkBoard() {
    d3.select("body").select("#arena").select("svg").selectAll("rect")
        .data(workBoard)
        .transition()
        .duration(250)
        .ease("sinIn")
        .attr("x", function(d, i) {
            return d.x;
        })
        .attr("y", function(d, i) {
            return d.y;
        })
        .style("fill", function(d, i) {
            if (d.face == 0) return "white";
            if (d.face > 0) return "blue";
        });
    d3.select("body").select("#arena").select("svg").selectAll("text")
        .data(workBoard)
        .transition()
        .duration(2000)
        .attr("x", function(d, i) {
            return d.x + (tileSize / 2);
        })
        .attr("y", function(d, i) {
            return d.y + (tileSize / 1.4);
        })
        .attr("pointer-events", "none")
        .style("text-anchor", "middle")
        .text(function(d) {
            if (d.face == 0) return "";
            if (d.face > 0) return d.face;
        });
}

function processMove(d, i) {
    if (checkValidMove(d) == true) {
        numberOfMoves++;
        adjustWorkBoard(i, blankLocation);
        showButtons();
        if (checkSolved() == true) {
            getBestScore();
            showButtons();
            solved();
        }
    }
}

function initButtons() {
    d3.select("body").select("#controlArea").select("svg").selectAll("rect")
        .data(labels)
        .enter()
        .append("rect")
        .attr("id", function(d, i) {
            return "button" + i;
        })
        .attr("x", function(d, i) {
            return (xLim / 3) * i + ((wide - xLim) / 2);
        })
        .attr("y", function(d, i) {
            return 50;
        })
        .attr("width", buttonWidth)
        .attr("height", buttonHeight)
        .attr("rx", 7)
        .attr("ry", 7)
        .style("fill", "blue")
        .style("fill-opacity", 0.5)
        .on("click", function(d, i) {
            if (i == 2) {
                resetGame();
            }
        });

    var texts = d3.select("body").select("#controlArea").select("svg").selectAll("text")
        .data(labels)
        .enter();
    texts
        .append("text")
        .attr("x", function(d, i) {
            return ((xLim / 3) * i) + (buttonWidth / 2) + ((wide - xLim) / 2);
        })
        .attr("y", function(d, i) {
            return 35 + (buttonHeight / 2);
        })
        .attr("font-family", "Architects Daughter")
        .attr("font-size", "1.5em")
        .attr("pointer-events", "none")
        .style("fill", "black")
        .style("text-anchor", "middle")
        .text(function(d, i) {
            return d;
        });
    texts
        .append("text")
        .attr("id", function(d, i) {
            return "lineTwo" + i;
        })
        .attr("x", function(d, i) {
            return ((xLim / 3) * i) + (buttonWidth / 2) + ((wide - xLim) / 2);
        })
        .attr("y", function(d, i) {
            return 75 + (buttonHeight / 2);
        })
        .attr("font-family", "Architects Daughter")
        .attr("font-size", "1.5em")
        .attr("pointer-events", "none")
        .style("fill", "black")
        .style("text-anchor", "middle")
        .text(function(d, i) {
            switch (i) {
                case (0):
                    {
                        return numberOfMoves;
                        break;
                    }
                case (1):
                    {
                        return bestScore;
                        break;
                    }
                case (2):
                    {
                        return "Game";
                        break;
                    }
            }
        });
}

function showButtons() {
    d3.select("body").select("#controlArea").selectAll("text").selectAll(".lineTwo")
        .data(labels)
        .transition()
        .duration(2000)
        .text(function(d, i) {
            switch (i) {
                case (0):
                    {
                        return d;
                        break;
                    }
                case (1):
                    {
                        return d;
                        break;
                    }
                case (2):
                    {
                        return d;
                        break;
                    }
            }
        })
    var elem;
    for (i = 0; i < 3; i++) {
        elem = "lineTwo" + i;
        switch (i) {
            case (0):
                {
                    content = numberOfMoves;
                    break;
                }
            case (1):
                {
                    content = bestScore;
                    break;
                }
            case (2):
                {
                    content = "Game";
                    break;
                }
        }
        document.getElementById(elem).innerHTML = content;
    }

}

function solved() {
    d3.select("body").select("#arena").select("svg").selectAll("rect")
        .data(workBoard)
        .transition(5000)
        .style("fill", function(d, i) {
            if (d.face == 0) return "white";
            if (d.face > 0) return "gray";
        })
        .attr("pointer-events", "none");
}

resetGame();