using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(ADCAvl.Startup))]
namespace ADCAvl
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
