# **Conway's Game of Life - Assembly x86 Implementation**  

## **Overview**  
This project implements Conway's Game of Life, a cellular automaton designed by John Horton Conway, using Assembly x86. It simulates the evolution of a grid of cells based on a set of simple rules. The implementation demonstrates the capabilities of low-level programming in processing complex algorithms.

The Game of Life operates on a 2D grid of cells, where each cell is either alive (1) or dead (0). The program calculates the state of the grid after applying the following rules:  
1. Any live cell with fewer than two live neighbors dies (underpopulation).  
2. Any live cell with two or three live neighbors survives to the next generation.  
3. Any live cell with more than three live neighbors dies (overpopulation).  
4. Any dead cell with exactly three live neighbors becomes a live cell (reproduction).  

---

## **Features**  
- **Optimized Assembly Code**: Implements the logic for Conway's Game of Life in x86 Assembly.  
- **Customizable Input**: Users can define grid dimensions, initial live cells, and the number of generations to simulate.  
- **Grid State Display**: Outputs the state of the grid after simulation.  

---

## **Input and Output Structure**  

### Input Format  
The input specifies the initial state of the grid and follows this format:  
1. `m` - Number of rows in the grid.  
2. `n` - Number of columns in the grid.  
3. `p` - Number of initially live cells.  
4. The next `p` lines contain the coordinates `(x, y)` of live cells.  
5. `k` - Number of generations to simulate.  

Example Input:  
3 // m - number of rows 4 // n - number of columns 5 // p - number of initially live cells 0 1 // Coordinates of the first live cell 0 2 // Coordinates of the second live cell 1 0 // Coordinates of the third live cell 2 2 // Coordinates of the fourth live cell 2 3 // Coordinates of the fifth live cell 5 // k - Number of generations


### Output Format  
The output displays the final state of the grid after `k` generations, with `0` representing a dead cell and `1` representing a live cell.

Example Output:  
0 0 0 0
0 0 0 0
0 0 0 0

## **Additional Examples**  

### Example 1  
- **Input**:
3
4
4
0 0
0 1
1 0
1 1
5

- **Output**:
0 0 0 0
0 1 1 0
0 1 1 0
