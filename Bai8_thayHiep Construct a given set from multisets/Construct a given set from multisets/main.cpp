//
//  main.cpp
//  Inverted index
//
//  Created by Dai Long on 4/21/18.
//  Copyright © 2018 Dai Long. All rights reserved.
//

#include <algorithm>
#include <fstream>
#include <iostream>
#include <vector>
#include <string>
#include <queue>
#include <map>

const std::string _CHARS = "0123456789";
const size_t MAX_NODES = 10;

class node {
    //MARK: properties
public:
    bool isWord;
    std::vector<std::string> files;
    node* next[MAX_NODES]; //10 con tro node
    
    //MARK: method
public:
    //Khai bao mac dinh
    node() { clear(); }
    
    //constructor and destructor
    node(char z) { clear(); }
    
    ~node() {
        for(int x = 0; x < MAX_NODES; x++)
            if(next[x]) delete next[x];
    }
    
    void clear() {
        for(int x = 0; x < MAX_NODES; x++) {
            next[x] = 0; //all null
            isWord = false;
        }
    }
    

};

class index {
public:
    void add(std::string s, std::string fileName) {
        std::transform( s.begin(), s.end(), s.begin(), tolower );
        std::string h;
        for( std::string::iterator i = s.begin(); i != s.end(); i++ ) {
            if( *i == 32 ) {
                pushFileName(addWord( h ), fileName); //gap space => push file name
                h.clear();
                continue;
            }
            h.append( 1, *i );
        }
        
        if( h.length() )
            pushFileName(addWord( h ), fileName);
    }
    
    std::vector<int> findWord( std::string s ) {
        
        int num;
        
        std::vector<int> numLine = std::vector<int>();
        std::vector<std::string> v = find( s );
        if( !v.size() ) {
            std::cout << s + " was not found!\n";
            return numLine;
        }
        
        std::cout << s << " found in:\n";
        for( std::vector<std::string>::iterator i = v.begin(); i != v.end(); i++ ) {
            std::cout <<"line "<< *i << "\n";
            num = std::stoi(*i);
            numLine.push_back(num);
        }
        std::cout << "\n";
        
        //convert

        return numLine;
    }
    
private:
    void pushFileName(node* n, std::string fn) { //dua File ma Node "n" xuat hien vao
        std::vector<std::string>::iterator i = std::find( n->files.begin(), n->files.end(), fn );
        if( i == n->files.end() ) n->files.push_back( fn );
    }
    
    const std::vector<std::string>& find( std::string s ) { // tra ve Vector cac file ma string s xuat hien
        size_t idx;
        std::transform( s.begin(), s.end(), s.begin(), tolower );
        node* rt = &root;
        
        
        for( std::string::iterator i = s.begin(); i != s.end(); i++ ) {
            idx = _CHARS.find(*i);
            if( idx < MAX_NODES ) {
                if(!rt->next[idx]) return std::vector<std::string>();
                rt = rt->next[idx];
            }
        }
        
        if( rt->isWord ) return rt->files;
        
        return std::vector<std::string>();
    }
    
    node* addWord( std::string s ) {
        size_t idx;
        node *rt = &root, *n;
        for( std::string::iterator i = s.begin(); i != s.end(); i++ ) {
            idx = _CHARS.find(*i); // vi tri cua ky tu trong string CHARS
            if( idx < MAX_NODES ) {
                n = rt->next[idx]; // n = root.next[idx]
                
                if( n ){ //neu n khong NULL
                    rt = n;
                    continue;
                }
                n = new node(*i);
                rt->next[idx] = n; //root.next[idx] = node(*i)
                rt = n; //dia chi cua n
            }
        }
        rt->isWord = true;
        return rt; //rt tro toi cuoi tu => Node cuoi chua file
    }
    node root;
    
};

void filter(std::map<int, std::vector<int> > &dataSet) {
    if (dataSet.size() == 1) {
        auto it = dataSet.begin();
        std::cout << (it->second).front() <<std::endl;
        return;
    }
    //line Appear
    std::map<int, int> LineAppear; //line and solan xuat hien
    //So element and Line appear
    std::map<int, std::map<int,std::vector<int> > > elementSet; //so lan xuat hien: LINE - vector element
    //Queue
    std::queue<int> myQueue;
    
    //preprocess
    int max = 1;
    int lineLabel;
    //for each element
    for (auto element = dataSet.begin(); element != dataSet.end(); element++) { //map
        //for each line
        for (auto LINE = (element->second).begin(); LINE != (element->second).end(); LINE++) { //vector
            //if (!(lineappear[line] == 0))line da them roi =>
            if (!(LineAppear[*LINE] == 0) ) {
                //So lan xuat hien_line + 1 ===== map<line, so lan xuat hien>
                LineAppear[*LINE]++;
                if (max < LineAppear[*LINE]) {
                    max = LineAppear[*LINE];
                    lineLabel = *LINE;
                }
            }
            
            else {
                //push -> queue
                myQueue.push(*LINE);
                //danh dau line da them roi.
                LineAppear[*LINE] = 1;
                //tang  solanxuat hien cua line + 1
            }
            
        }
    }
    
    std::cout <<lineLabel<<std::endl;
    //if Max = so element => In KQ line do ra va Ket thuc
    if (max == dataSet.size() ) {
        return;
    }

    std::map<int, std::vector<int> > dataNEW = dataSet;
    for (auto element = dataSet.begin(); element != dataSet.end(); element++) {
        for (auto it = (element->second).begin(); it != (element->second).end(); it++) {
            if (*it == lineLabel) {
                dataNEW.erase(element->first);
                break;
            }
        }
        
    }
    
    
    if (dataNEW.size() == 1) {
        auto it = dataNEW.begin();
        std::cout << (it->second).front() <<std::endl;
        return;
    }
    //if element con lai > 1
    if (dataNEW.size() > 1) {
        //dequy (element conlai)
        filter(dataNEW);
    }

    
}


int main( int argc, char* argv[] ) {
    class index t;
    std::string s, lineString, lineCount;
    int count = 1;

    std::string path = "/Users/dailong/OneDrive - Hanoi University of Science and Technology/LEARNED/DATA STRUCTURE AND ALGORITHM/Data Structure and Algorithm/Bai8_thayHiep Construct a given set from multisets/file1.txt";
    
    std::ifstream f;
    f.open(path.c_str(), std::ios::in);
    if( f.good()) {
        while( !f.eof() ) {
            lineCount = std::to_string(count);
            getline(f, lineString);
            for (std::string::iterator i = lineString.begin(); i != lineString.end(); i++) {
                if ( (*i == ' ') || (*i == ',')|| (*i == '.') || (*i == '\"')|| (*i == '\n') ) {
                    t.add(s, lineCount);
                    s.clear();
                    continue;
                }
                s.push_back(*i);
            }
            t.add(s, lineCount);
            s.clear();
            
            count++;
        }
        f.close();
    }
    else {std::cout << "cant read file!";}

    //read tap mau
    
    std::map<int, std::vector<int> > dataSet; //element and list line
    
    std::vector<int> tempt;
    int num;
    while( true ) {
        std::cout << "Enter one word to search for, return to exit: ";
        std::getline( std::cin, s );
        if( !s.length() ) break;
        num = std::stoi(s);
        
        //add vao tap du lieu
        tempt = t.findWord(s);
        if (tempt.size() == 0) {
            tempt.clear();
            continue;
        }
        dataSet[num] = tempt;
    }
    
    //find
    filter(dataSet);
    return 0;
}
