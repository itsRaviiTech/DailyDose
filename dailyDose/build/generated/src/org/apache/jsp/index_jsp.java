package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import model.AdviceBean;
import model.WeatherBean;
import model.NewsBean;
import model.NewsBean.NewsArticle;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    // Instantiate your beans
    AdviceBean adviceBean = new AdviceBean();
    WeatherBean weatherBean = new WeatherBean(); // Use default city or modify constructor to accept city
    NewsBean newsBean = new NewsBean();
    java.util.List<NewsArticle> articles = newsBean.getArticles();

      out.write("\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <title>DailyDose - Home</title>\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${pageContext.request.contextPath}", java.lang.String.class, (PageContext)_jspx_page_context, null));
      out.write("/styles.css\" />\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <div class=\"container\">\n");
      out.write("\n");
      out.write("            <h1 class=\"app-title\">DailyDose</h1>\n");
      out.write("\n");
      out.write("            ");
      out.write("\n");
      out.write("            <div class=\"card advice-card\">\n");
      out.write("                <p class=\"advice-text\">“");
      out.print( adviceBean.getAdvice());
      out.write("”</p>\n");
      out.write("                <form method=\"get\" class=\"refresh-form\">\n");
      out.write("                    <button type=\"submit\" class=\"refresh-btn\">Refresh Advice</button>\n");
      out.write("                </form>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            ");
      out.write("\n");
      out.write("            <div class=\"card weather-card\">\n");
      out.write("                <h3>Current Weather</h3>\n");
      out.write("                <p id=\"weather\">Detecting your location...</p>\n");
      out.write("                <form action=\"weather.jsp\" method=\"post\" class=\"refresh-form\">\n");
      out.write("                    <button type=\"submit\" class=\"refresh-btn\">Search Location....</button>\n");
      out.write("                </form>\n");
      out.write("\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            ");
      out.write("\n");
      out.write("            <div class=\"card news-card weather\">\n");
      out.write("                <h3>Top News Headlines</h3>\n");
      out.write("                <ul>\n");
      out.write("                    ");
 for (NewsArticle article : articles) {
      out.write("\n");
      out.write("                    <li>\n");
      out.write("                        <a href=\"");
      out.print( article.getUrl());
      out.write("\" target=\"_blank\" class=\"news-link\">\n");
      out.write("                            ");
      out.print( article.getTitle());
      out.write("\n");
      out.write("                        </a><br/>\n");
      out.write("                        <small>");
      out.print( article.getSource());
      out.write(" - ");
      out.print( article.getPublishedDate());
      out.write("</small>\n");
      out.write("                    </li>\n");
      out.write("                    ");
 }
      out.write("\n");
      out.write("                </ul>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        ");
      out.write("\n");
      out.write("        <nav class=\"bottom-nav\">\n");
      out.write("            <a href=\"index.jsp\" class=\"nav-link active\">Home</a>\n");
      out.write("            <a href=\"weather.jsp\" class=\"nav-link\">Weather</a>\n");
      out.write("            <a href=\"news.jsp\" class=\"nav-link\">News</a>\n");
      out.write("        </nav>\n");
      out.write("        <script src=\"currentGeoLocation.js\"></script>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
