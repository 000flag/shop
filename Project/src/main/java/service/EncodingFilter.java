package service;

import javax.servlet.*;
import java.io.IOException;

public class EncodingFilter implements Filter {
  public void init(FilterConfig filterConfig) throws ServletException {
  }

  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
      throws IOException, ServletException {
    if (request.getContentType() != null && request.getContentType().startsWith("multipart/form-data")) {
      chain.doFilter(request, response);
      return;
    }

    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    chain.doFilter(request, response);
  }


  public void destroy() {
  }
}
