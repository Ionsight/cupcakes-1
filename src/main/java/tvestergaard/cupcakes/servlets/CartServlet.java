package tvestergaard.cupcakes.servlets;


import tvestergaard.cupcakes.*;
import tvestergaard.cupcakes.database.PrimaryDatabase;
import tvestergaard.cupcakes.database.bottoms.Bottom;
import tvestergaard.cupcakes.database.bottoms.BottomDAO;
import tvestergaard.cupcakes.database.bottoms.MysqlBottomDAO;
import tvestergaard.cupcakes.database.toppings.MysqlToppingDAO;
import tvestergaard.cupcakes.database.toppings.Topping;
import tvestergaard.cupcakes.database.toppings.ToppingDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CartServlet",
        urlPatterns = "/cart")
public class CartServlet extends HttpServlet
{

    /**
     * Serves the /custom page where users can create their own cupcake.
     *
     * @param request  The request.
     * @param response The response.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        Notifications notifications = new Notifications(request);
        Authentication authentication = new Authentication(request, response);

        if (!authentication.isAuthenticated()) {
            notifications.error(Language.ERROR_ACCESS_USER);
            authentication.redirect("cart");
            return;
        }

        new Cart(request);
        new Notifications(request);
        request.getRequestDispatcher("WEB-INF/cart.jsp").forward(request, response);
    }

    /**
     * Serves the /preset page where users can see information about the bottom with the provided id.
     *
     * @param request  The request.
     * @param response The response.
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        Notifications notifications = new Notifications(request);
        Authentication authentication = new Authentication(request, response);

        if (!authentication.isAuthenticated()) {
            notifications.error(Language.ERROR_ACCESS_USER);
            authentication.redirect("cart");
            return;
        }

        Parameters parameters = new Parameters(request);

        if (parameters.isNull("bottom") || !parameters.isInt("bottom") ||
                parameters.isNull("topping") || !parameters.isInt("topping") ||
                parameters.isNull("amount") || !parameters.isInt("amount")) {
            notifications.error("Error with parameters.");
            response.sendRedirect(request.getHeader("referer"));
            return;
        }

        PrimaryDatabase source = new PrimaryDatabase();
        BottomDAO bottomDAO = new MysqlBottomDAO(source);
        ToppingDAO toppingDAO = new MysqlToppingDAO(source);

        Bottom bottom = bottomDAO.get(parameters.getInt("bottom"));
        Topping topping = toppingDAO.get(parameters.getInt("topping"));

        if (bottom == null) {
            notifications.error("Bottom doesn't exist.");
            response.sendRedirect(request.getHeader("referer"));
            return;
        }

        if (topping == null) {
            notifications.error("Bottom doesn't exist.");
            response.sendRedirect(request.getHeader("referer"));
            return;
        }

        Cart cart = new Cart(request);
        int amount = parameters.getInt("amount");
        cart.addItem(new Cart.Item(bottom, topping, amount));
        response.sendRedirect("cart");
    }
}