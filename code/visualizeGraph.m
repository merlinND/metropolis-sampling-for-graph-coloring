function visualizeGraph(G,coloring, title_text)

    figure;
    g = graph(G);
    proper_edge = coloring(g.Edges.EndNodes(:,1)) ~= coloring(g.Edges.EndNodes(:,2));
    p = plot(g,'NodeLabel',coloring,'MarkerSize',6,'Layout','force','Iterations',100);
    gray_level=0.7;
    p.EdgeColor = [proper_edge + ~proper_edge*gray_level, proper_edge*gray_level, proper_edge*gray_level];
    p.LineWidth = 0.5+~proper_edge;
    %p.LineStyle = '--';
    title(title_text);
    axis off
    
end