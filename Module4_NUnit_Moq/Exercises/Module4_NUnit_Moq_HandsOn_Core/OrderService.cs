namespace Module4_Core;

public interface IEmailSender
{
    void Send(string to, string message);
}

public class OrderService
{
    private readonly IEmailSender _emailSender;

    public OrderService(IEmailSender emailSender)
    {
        _emailSender = emailSender;
    }

    public void PlaceOrder(string customerEmail)
    {
        if (string.IsNullOrWhiteSpace(customerEmail))
            throw new ArgumentException("Email is required.");

        _emailSender.Send(customerEmail, "Order placed successfully.");
    }
}
