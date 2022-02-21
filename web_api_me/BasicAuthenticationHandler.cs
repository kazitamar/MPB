using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;
using web_api_me;

public class BasicAuthenticationHandler : AuthenticationHandler<AuthenticationSchemeOptions>
{
    public BasicAuthenticationHandler(IOptionsMonitor<AuthenticationSchemeOptions> options, ILoggerFactory logger, UrlEncoder encoder, ISystemClock clock)
        : base(options, logger, encoder, clock) { }

    protected override Task<AuthenticateResult> HandleAuthenticateAsync()
    {
        Response.Headers.Add("WWW-Authenticate", "Basic");

        if (!Request.Headers.ContainsKey("Authorization"))
        {
            return Task.FromResult(AuthenticateResult.Fail("Authorization header is missing"));
        }

        var authHeader = Request.Headers["Authorization"].ToString();
        if (authHeader.StartsWith("basic", StringComparison.OrdinalIgnoreCase))
        {
            var token = authHeader.Substring("Basic ".Length).Trim();
            //Console.WriteLine(token);
            var credentialstring = Encoding.UTF8.GetString(Convert.FromBase64String(token));
            var credentials = credentialstring.Split(':');
            MPB mpb = new MPB();
            if (mpb.IsPassMatchUser(credentials[0], credentials[1]))
            {
                var claims = new[] { new Claim("Name", credentials[0]), new Claim(ClaimTypes.Role, "Admin") };
                var identity = new ClaimsIdentity(claims, "Basic");
                var claimsPrincipal = new ClaimsPrincipal(identity);
                return Task.FromResult(AuthenticateResult.Success(new AuthenticationTicket(claimsPrincipal, Scheme.Name)));
            }
            Response.StatusCode = 401;
            return Task.FromResult(AuthenticateResult.Fail("Invalid Credentials"));
        }
        else
        {
            Response.StatusCode = 401;
            return Task.FromResult(AuthenticateResult.Fail("Invalid Authorization Header"));
        }
    }
}