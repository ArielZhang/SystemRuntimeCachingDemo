using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Caching;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SystemRuntimeCachingDemo
{
    public partial class Default : System.Web.UI.Page
    {
        private static readonly ObjectCache cache = new MemoryCache("CacheDemo");
        //private static readonly ObjectCache cache = MemoryCache.Default; 

        private static string message = null;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Cache_Click(object sender, EventArgs e)
        {
            CacheItemPolicy policy = new CacheItemPolicy();

            if (!string.IsNullOrEmpty(ExpirationTime.Text))
            {
                double time = Convert.ToDouble(ExpirationTime.Text);
                if (ExpirationType.SelectedValue == "SlidingExpiration")
                {
                    policy.SlidingExpiration = TimeSpan.FromSeconds(time);
                }

                if (ExpirationType.SelectedValue == "AbsoluteExpiration")
                {
                    policy.AbsoluteExpiration = DateTimeOffset.Now.AddSeconds(time);
                }
            }

            if (PolicyCallback.SelectedValue == "CacheEntryRemovedCallback")
            {
                policy.RemovedCallback = args =>
                {
                    message += "Cahce Item: " + "Key: " + args.CacheItem.Key + " Value: " + args.CacheItem.Value + " Removed&nbsp&nbsp&nbsp&nbsp" + "    Reason: " + args.RemovedReason + " Source: " + args.Source + "&nbsp&nbsp&nbsp&nbsp";
                };
            }
            else
            {
                policy.UpdateCallback = args =>
                {
                    message = "Cache Item Key: " + args.Key + " is  about to be removed, Reason: " + args.RemovedReason + "&nbsp&nbsp&nbsp&nbsp";
                    if (args.UpdatedCacheItem != null)
                    {
                        message += "Updated by: Key: " + args.UpdatedCacheItem.Key + " Value: " + args.UpdatedCacheItem.Value + "&nbsp&nbsp&nbsp&nbsp";
                    }
                };
            }

            if (PriorityList.SelectedValue == "NotRemovable")
            {
                policy.Priority = CacheItemPriority.NotRemovable;
            }

            cache.Set(CacheKey.Text, CacheData.Text, policy);

            if (!string.IsNullOrEmpty(Monitor.Text))
            {
                string[] keys = Monitor.Text.Split(new char[] { ',' });
                ChangeMonitor monitor = cache.CreateCacheEntryChangeMonitor(keys);
                monitor.NotifyOnChanged(state =>
                {
                    message += "Dependent Items Changed!! Key: " + CacheKey.Text + " denpend " + Monitor.Text + "&nbsp&nbsp&nbsp&nbsp"; 
                });
                policy.ChangeMonitors.Add(monitor);
            }

            Messages.Text += "Cache Item: Key: " + CacheKey.Text + " Value: " +  CacheData.Text + " cached!&nbsp&nbsp&nbsp&nbsp";
        }

        private void OnDependencyChanged(object state)
        {
            IEnumerable<string> dependencyKeys = (IEnumerable<string>)state;
            foreach (string depend in dependencyKeys)
            {
                message += depend + ", ";
            }
            message += " changed!&nbsp&nbsp&nbsp&nbsp";
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(message))
            {
                Messages.Text += message;
                message = null;
            }
        }

        protected void Clear_Click(object sender, EventArgs e)
        {
            foreach (var element in cache)
            {
                cache.Remove(element.Key);
                Messages.Text += "Cache Item: Key: " + element.Key + " Value: " + element.Value + " be Removed! &nbsp&nbsp&nbsp&nbsp";
            }
        }

        protected void ViewAllCacheBtn_Click(object sender, EventArgs e)
        {
            Messages.Text += cache.GetCount() + " cache items cached!&nbsp&nbsp&nbsp&nbsp";
            foreach (var element in cache)
            {
                Messages.Text += "Cache Item: Key: " + element.Key + " Value: " + element.Value + "&nbsp&nbsp&nbsp&nbsp";
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            string key = CacheItemKey.Text;

            if (string.IsNullOrEmpty(key))
            {
                return;
            }

            CacheItem item = cache.GetCacheItem(key);
            if (item == null)
            {
                Messages.Text += "Cache Item: Key: " + key + " not found!&nbsp&nbsp&nbsp&nbsp";
                return;
            }

            Messages.Text += "Cahe Item: Key: " + item.Key + " Value: " + item.Value + " found! &nbsp&nbsp&nbsp&nbsp";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string key = CacheItemKey.Text;

            if (string.IsNullOrEmpty(key))
            {
                return;
            }

            CacheItem item = cache.GetCacheItem(key);
            if (item == null)
            {
                Messages.Text += "Cache Item: Key: " + key + " not found!&nbsp&nbsp&nbsp&nbsp";
                return;
            }

            cache.Remove(key);
            Messages.Text += "Cahe Item: Key: " + item.Key + " Value: " + item.Value + " removed! &nbsp&nbsp&nbsp&nbsp";
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(TrimPer.Text))
            {
                int percent = Convert.ToInt32(TrimPer.Text);
                MemoryCache memCache = cache as MemoryCache;
                if (memCache != null)
                {
                    long removed = memCache.Trim(percent);
                    Messages.Text += removed + " cache items trimed!&nbsp&nbsp&nbsp&nbsp";
                }
            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < 10000; i++)
            {
                cache.Set(i.ToString(), i, new CacheItemPolicy());
            }
        }
    }
}