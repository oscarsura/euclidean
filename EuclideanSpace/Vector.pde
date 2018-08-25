public class Vector {
    private static final int kDefaultDimension = 0;
    private int dimension = kDefaultDimension;    
    private int[] vector;
    
    public Vector(int... vector) {
        this.dimension = vector.length;
        this.vector = new int[dimension];
        
        for (int i = 0; i < dimension; i++) {
            this.vector[i] = vector[i];        
        }
    }
    
    private static final int kOutOfBounds = -1;
    public int getComponent(int index) {
        boolean inBounds = (index >= 0) && (index < vector.length);
        return inBounds ? vector[index] : kOutOfBounds;
    }
    
    public int getDimension() {
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
