//
//  main.cpp
//  Bai10_thayHiep Graph
//
//  Created by Dai Long on 5/2/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//
/* test1
 4
 0 1 0 1
 0 0 0 1
 0 0 0 0
 1 0 1 0
 */

//  Algorithm
/* Using Depth First Search
 traversal all vertices
    if Not Checked: DFS(vertex)
 
 procerduce DFS
    add vertex to Stack
    explore(Vertex) = true
    checked u
 
    traversal all each adjacency of vertex u
        if explore(v)
            add (u,v) to backEdge
            save Path from currently Stack (copy)
            print Path
        else: DFS(v)
 
    un explored u;
    remove vertex u from Stack
 
 */



#include <iostream>
#include <fstream>
#include <stack>
#include <stdlib.h>
#include <vector>
using namespace std;




class Graph {
    //MARK: properties
public:
    int **adjMatrix;
    bool *explored;
    int num_v;
    vector<int> myStack;
    bool *check;
    
    Graph(){}
    Graph(int num_v) {
        adjMatrix = new int *[num_v];
        int *row = new int[num_v*num_v];
        for (int r = 0; r < num_v; r++) {
            adjMatrix[r] = row;
            row += num_v;
        }
    }
    
    
    //backEdge
    vector<pair<int, int> > backEdge;

    //MARK: method
    void findcycle()  {
        explored = new bool[num_v]();
        check = new bool[num_v]();

        for (int i = 0; i < num_v; i++) {
            if (check[i] == false) {
                dfs(i);
            }
        }
    }
    
    void dfs(int u) {
        myStack.push_back(u);
        explored[u] = true;
        check[u] = true;
        
        for (int i = 0; i < num_v; i++) {
            if (adjMatrix[u][i] == 0) continue;
            if (explored[i] == true) {
                backEdge.push_back(make_pair(i, u));
                vector<int> path(myStack);
                int value = path.back();
                cout << "Cycle: ";
                while (value != i) {
                    cout << value << " - ";
                    path.pop_back();
                    value = path.back();
                }
                cout << value <<".\n";
            }
            else {
                dfs(i);
            }
        }
        
        explored[myStack.back()] = false;
        myStack.pop_back();
    }
};

Graph readfile() {
    char path[] = "/Users/dailong/OneDrive - Hanoi University of Science and Technology/LEARNED/DATA STRUCTURE AND ALGORITHM/Data Structure and Algorithm/Bai10_thayHiep Graph/Bai10_thayHiep Graph/adjacency_matrix.txt";
    ifstream file(path);
    if (file.fail()) {
        cout <<  "cant read file!\n";
        return Graph();
    }
    int v;
    file >> v;
    Graph graph(v);
    graph.num_v = v;

    int tempt;
    for (int i = 0; i < v; i++) {
        for (int j = 0; j < v; j++) {
            file >> tempt;
            graph.adjMatrix[i][j] = tempt;
            if (i == j) continue;
        }
    }
    return graph;
}

int main(int argc, const char * argv[]) {
    Graph graph = readfile();
    graph.findcycle();
    
    return 0;
}
