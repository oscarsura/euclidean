public class Vector {
    
    private static final int kDefaultDimension = 0;
    private int dimension; 
    private int[] vector;
    
    public Vector() {
        this.dimension = kDefaultDimension;
        vector = new int[0];
    }
    
    public Vector(int... vector) {
        this.dimension = vector.length;
        this.vector = new int[dimension];
        
        for (int i = 0; i < dimension; i++) {
            this.vector[i] = vector[i];        
        }
    }
    
    public void addComponent(int value) {
        int[] newVector = new int[++dimension];
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
    
    private static final int kDimensionMismatch = -1;
    public int dotProduct(Vector vector2) {
        int product = 0;
        int[] w = vector2.asArray();
        int[] v = vector;
        
        int components = (w.length == v.length) ? dimension : kDimensionMismatch;
        for (int i = 0; i < components; i++) {
            product += w[i] * v[i];        
        }
        return product;
    }
    
    public float angle(Vector vector2) {
        int dp = this.dotProduct(vector2);
        float mag = this.magnitude() * vector2.magnitude();
        return (float)Math.acos(dp / mag);
    }
    
    public float magnitude() {
        int squaredSum = 0;
        for (int i : vector) {
            squaredSum += Math.pow(i, 2);
        }
        return (float)Math.pow(squaredSum, 1/2);  
    }
    
    public int dimension() {
        return dimension;    
    }
    
    public int[] asArray() {
        return vector;    
    }
    
    @Override
    public String toString() {
        String output = "";
        output += "(";
        for (int i = 0; i < dimension; i++) {
            output += Integer.toString(vector[i]);
            if (i < dimension - 1) output += ", ";
        }
        output += ")";
        return output;
    }
}
