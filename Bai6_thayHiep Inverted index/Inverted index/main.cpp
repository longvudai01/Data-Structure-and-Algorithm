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


const std::string _CHARS = "abcdefghijklmnopqrstuvwxyz0123456789.:-_/";
const size_t MAX_NODES = 41;

class node {
    //MARK: properties
public:
    bool isWord;
    std::vector<std::string> files;
    node* next[MAX_NODES]; //41 con tro node
    
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
    
    void findWord( std::string s ) {
        std::vector<std::string> v = find( s );
        if( !v.size() ) {
            std::cout << s + " was not found!\n";
            return;
        }
        
        std::cout << s << " found in:\n";
        for( std::vector<std::string>::iterator i = v.begin(); i != v.end(); i++ ) {
            std::cout << *i << "\n";
        }
        std::cout << "\n";
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


int main( int argc, char* argv[] ) {
    class index t;
    std::string s, lineString, lineCount;
    int count = 1;

    std::string path = "/Users/dailong/OneDrive - Hanoi University of Science and Technology/LEARNED/DATA STRUCTURE AND ALGORITHM/Data Structure and Algorithm/Bai6_thayHiep Inverted index/file1.txt";
    
    
        std::ifstream f;
        f.open(path.c_str(), std::ios::in);
        if( f.good()) {
            while( !f.eof() ) {
                lineCount = "line " + std::to_string(count);
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

    
    while( true ) {
        std::cout << "Enter one word to search for, return to exit: ";
        std::getline( std::cin, s );
        if( !s.length() ) break;
        t.findWord( s );
        
    }
    return 0;
}
