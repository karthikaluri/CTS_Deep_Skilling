package builderpattern;

/**
 * Exercise 3: Builder Pattern Implementation
 * 
 * This class demonstrates the Builder pattern for constructing
 * complex Person objects with multiple optional fields.
 */
public class Person {
    private String name;
    private int age;
    private String email;
    private String phone;
    private String address;

    // Private constructor - can only be called by PersonBuilder
    private Person(PersonBuilder builder) {
        this.name = builder.name;
        this.age = builder.age;
        this.email = builder.email;
        this.phone = builder.phone;
        this.address = builder.address;
    }

    // Getters
    public String getName() { return name; }
    public int getAge() { return age; }
    public String getEmail() { return email; }
    public String getPhone() { return phone; }
    public String getAddress() { return address; }

    @Override
    public String toString() {
        return "Person {" +
                "name='" + name + '\'' +
                ", age=" + age +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                '}';
    }

    /**
     * Static nested PersonBuilder class
     * Implements the Builder pattern for Person construction
     */
    public static class PersonBuilder {
        private String name;
        private int age = 0;
        private String email = "";
        private String phone = "";
        private String address = "";

        public PersonBuilder(String name) {
            this.name = name;
        }

        public PersonBuilder age(int age) {
            this.age = age;
            return this;
        }

        public PersonBuilder email(String email) {
            this.email = email;
            return this;
        }

        public PersonBuilder phone(String phone) {
            this.phone = phone;
            return this;
        }

        public PersonBuilder address(String address) {
            this.address = address;
            return this;
        }

        public Person build() {
            if (name == null || name.isEmpty()) {
                throw new IllegalStateException("Name is required!");
            }
            return new Person(this);
        }
    }
}
