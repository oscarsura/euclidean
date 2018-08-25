public class Vector {
    private static final int kDefaultDimension = 0;
    private int dimension = kDefaultDimension;    
    private int[] vector;
    
    public Vector() {
        this.dimension = 0;
        vector = new int[0];
    }
    
    public Vector(int... vector) {
        this.dimension = vector.length;
        this.vector = new int[dimension];
        
        for (int i = 0; i < dimension; i++) {
            this.vector[i] = vector[i];        
        }
    }
    
    //need to ensure that this will expand the array, may be slow
    public void addComponent(int value) {
        int[] newVector = new int[dimension++];
        int index;
        for (index = 0; index < vector.length; index++) {
            newVector[index] = vector[index];   
        }
        newVector[index] = value;
        vector = newVector;
    }
    
    private static final int kOutOfBounds = -1;
    public int getAt(int index) {
        boolean inBounds = (index >= 0) && (index < vector.length);
        return inBounds ? vector[index] : kOutOfBounds;
    }
    
    public int dimension() {
        return dimension;    
    }
    
    public String toString() {
        String output = "";
        output += "(";
        for (int i = 0; i < dimension; i++) {
            if (i < dimension - 1) output += ", ";
            output += Integer.toString(vector[i]);
        }
        output += ")";
        return output;
    }
}
