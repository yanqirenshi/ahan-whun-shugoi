class GraphUtility {
    jiggle () {
        return Math.floor((Math.random() - 0.5) * 1000);
        // return (Math.random() - 0.5) * 1e-6 * 100;
    }
    initCommans (aws, commands) {
        return commands.map(function (node) {
            node = this.setDefaultPoint(node);
            node._parent = aws;
            return node;
        }.bind(this));
    }
    initSubcommands (command, subcommands) {
        let aws = command._parent;
        let vec = {x: command.location.x - aws.location.x, y:command.location.y - aws.location.y};
        return subcommands.map(function (node) {
            if (node.x==0) node.location.x = vec.x + command.location.x;
            if (node.y==0) node.location.y = vec.y + command.location.y;
            node._parent = command;
            return node;
        }.bind(this));
    }
    setDefaultPoint (node) {
        if (node.x == 0 && node.y == 0 && node.z == 0) {
            node.x = this.jiggle();
            node.y = this.jiggle();
            node.z = this.jiggle();
        }
        return node;
    }
    node_list2ht (list, ht) {
        for (var i in list) {
            let key = list[i]._id;
            ht[key] = list[i];
        }
        return ht;
    }
    edge_list2ht (parent_node, child_nodes_ht, edges, ht_r) {
        for (var i in edges) {
            let edge = edges[i];
            let child_node = child_nodes_ht[edge['to-id']];
            ht_r[edge._id] = edge;
            edge.display = parent_node.display && child_node.display;
        }
        return ht_r;
    }
    filterElements (elements) {
        return elements.filter(function (element) {
            return element.display;
        });
    }
    setEdgesDisplay (edges, fron_nodes, to_nodes) {
        for (var i in edges) {
            let edge = edges[i];
            let from_node = fron_nodes.ht[edge['from-id']];
            let to_node = to_nodes.ht[edge['to-id']];
            if (from_node && to_node)
                this.setEdgeDisplay(edge,from_node,to_node);
        }
        return edges;
    }
    setEdgeDisplay (edge, from_node, to_node) {
        edge.display = (from_node.display && to_node.display);
        return edge;
    }
    setCommandValues (from, target) {
        this.setObjectValues(from, target);
    }
    draw (graph, nodes, edges) {
        graph.setNodes(nodes);
        graph.setEdges(edges);
        graph.draw();
    }
    drawFirst (graph, svg_d3, svg_tag, base_tag, nodes, edges) {
        graph.setSvg(svg_d3);
        graph.resizeSvg(svg_tag,
                        base_tag.clientWidth,
                        base_tag.clientHeight);
        graph.initViewBox(svg_tag);

        if ((!nodes || nodes.length==0) &&
            !edges || edges.length==0)
            return;

        this.draw(nodes, edges);
    }
    /* **************************************************************** *
     *    ????                                                          *
     * **************************************************************** */
    marge2 (state, add_list) {
        let state_ht = state.ht;
        let state_list = state.list;

        for (var i in add_list) {
            let data = add_list[i];

            let state_data = state_ht[data._id];

            if (state_data) {
                this.setObjectValues(data, state_data);
            } else {
                state_ht[data._id] = data;
                state_list.push(data);
            }
        }

        return {
            ht: state_ht,
            list: state_list
        };
    }
    /* **************************************************************** *
     *                                                                  *
     *    Used                                                          *
     *                                                                  *
     * **************************************************************** */
    setObjectValues (source, target) {
        for (var key in source)
            target[key] = source[key];
        return target;
    }
    /* svg を整える */
    makeD3Svg (selector) {
        let w = window.innerWidth;
        let h = window.innerHeight;

        let svg_tag = document.getElementById(selector);
        svg_tag.setAttribute('height',h);
        svg_tag.setAttribute('width',w);

        let d3svg = new D3Svg({
            d3: d3,
            svg: d3.select('#' + selector),
            x: 0,
            y: 0,
            w: w,
            h: h,
            scale: 1
        });

        return d3svg;
    };
    /* いまつこてない */
    refreshSvgSize () {
        let tag = this.refs.svg;

        tag.setAttribute('width',window.innerWidth);
        tag.setAttribute('height',window.innerHeight);
    }
    /* レイヤー・グループ と ルーラー を描画する。 */
    drawBase (d3svg) {
        if (!d3svg)
            return;

        new D3Base().draw(d3svg);

        new D3Ruler().draw(d3svg, new D3Ruler().makeRules(88000, 500));
    }
}

class GraphNode {
    getLocation (core) {
        if (core._class=='AWS')
            return { x: 0, y:0, fx:0, fy:0 };

        let location = {
            x: 0,
            y: 0
        };

        if (core.location.X!=0 && core.location.Y!=0) {
            location.x = core.location.X;
            location.y = core.location.Y;
        }

        return location;
    }
    getCircleR (core) {
        if (core._class=='AWS') return 55;
        if (core._class=='COMMAND') return 33;
        if (core._class=='SUBCOMMAND') return 33;
        if (core._class=='OPTION') return 33;

        return 33;
    };
    getCircleFill (core) {
        if (core._class=='AWS')        return '#ff9901';
        if (core._class=='COMMAND')    return '#ffa31b';
        if (core._class=='SUBCOMMAND') return '#ffad34';
        if (core._class=='OPTION')     return '#ffb84e';

        return '#eeeeee';
    }
    getCircleStroke (core) {
        let color = 'rgba(' + core.stroke.COLOR.R + ', ' + core.stroke.COLOR.G + ', ' + core.stroke.COLOR.B + ', ' + core.stroke.COLOR.A + ')';
        return {
            color: color,
            width: core.stroke.WIDTH
        };
    }
    makeGraphNodeData (core) {
        let location = this.getLocation(core);
        return {
            x: location.x,
            y: location.y,
            fx: location.fx,
            fy: location.fy,
            label: {
                text: core.code,
                font: {
                    size: 12
                }
            },
            circle: {
                r: this.getCircleR(core),
                fill: this.getCircleFill(core),
                stroke: this.getCircleStroke(core)
            },
            _id: core._id,
            _class: core._class,
            _core: core
        };
    }
    updateGraphNodeData (source, target) {
        // ブラウザ側で変更できないものは更新する。
    }
    mergeNodes (sources, targets) {
        let targets_ht = targets.ht;

        for (var i in sources) {
            let source = sources[i];
            let target = targets_ht[source._id];

            if (target) {
                this.updateGraphNodeData(source, target);
            } else {
                let data = this.makeGraphNodeData(source);
                targets.ht[source._id] = data;
                targets.list.push(data);
            }
        }

        return targets;
    }
}

class GraphEdge {
    makeGraphEdgeData (core) {
        return {
            source: core['from_id'],
            target: core['to_id'],
            _core: core,
        };
    }
    updateGraphEdgeData (source, target) {}
    mergeEdges (sources, targets) {
        let targets_new = {
            ht: Object.assign({}, targets.ht),
            list: [].concat(targets.list)
        };

        let targets_ht = targets_new.ht;

        for (var i in sources) {
            let source = sources[i];
            let target = targets_ht[source._id];

            if (target) {
                this.updateGraphEdgeData(source, target);
            } else {
                let data = this.makeGraphEdgeData(source);
                targets_new.ht[source._id] = data;
                targets_new.list.push(data);
            }
        }

        return targets_new;
    }
}