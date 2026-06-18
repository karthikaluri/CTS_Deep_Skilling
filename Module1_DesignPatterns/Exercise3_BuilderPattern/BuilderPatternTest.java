package builderpattern;

/**
 * Test class for Builder Pattern Exercise 3
 * Demonstrates various ways to construct Person objects using the Builder
 */
public class BuilderPatternTest {
    public static void main(String[] args) {
        System.out.println("=== Builder Pattern Test ===\n");

        // Test 1: Build person with all fields
        System.out.println("Test 1: Person with all fields");
        Person person1 = new Person.PersonBuilder("John Doe")
                .age(30)
                .email("john@example.com")
                .phone("555-1234")
                .address("123 Main St")
                .build();
        System.out.println(person1);
        System.out.println();

        // Test 2: Build person with minimal fields
        System.out.println("Test 2: Person with minimal fields");
        Person person2 = new Person.PersonBuilder("Jane Smith")
                .age(25)
                .build();
        System.out.println(person2);
        System.out.println();

        // Test 3: Build person with some optional fields
        System.out.println("Test 3: Person with some optional fields");
        Person person3 = new Person.PersonBuilder("Bob Johnson")
                .email("bob@example.com")
                .phone("555-5678")
                .build();
        System.out.println(person3);
        System.out.println();

        // Test 4: Error handling - missing required field
        System.out.println("Test 4: Error handling - Missing required field");
        try {
            Person invalidPerson = new Person.PersonBuilder("")
                    .age(20)
                    .build();
        } catch (IllegalStateException e) {
            System.out.println("Error caught: " + e.getMessage());
        }
    }
}
