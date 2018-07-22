﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Forms;
using Blumind.Core;
using Blumind.Globalization;

namespace Blumind.Controls.MapViews
{
    partial class MindMapView
    {
        ToolStripButton TsbAddTopic;
        ToolStripButton TsbAddSubTopic;
        ToolStripButton TsbAddLink;
        ToolStripButton TsbAddIcon;
        ToolStripButton TsbAddRemark;
        ToolStripButton TsbAddProgressBar;
        ToolStripSeparator toolStripSeparator1;

        bool ToolStripItemsInited;

        public override IEnumerable<ToolStripItem> GetToolStripItems()
        {
            if (!ToolStripItemsInited)
            {
                InitializeToolStripItems();
            }

            return new ToolStripItem[]
            {
                TsbAddTopic,
                TsbAddSubTopic,
                TsbAddLink,
                //TsbAddIcon,
                //TsbAddRemark,
                //TsbAddProgressBar,
            };
        }

        void InitializeToolStripItems()
        {
            TsbAddTopic = new ToolStripButton();
            TsbAddSubTopic = new ToolStripButton();
            TsbAddLink = new ToolStripButton();
            TsbAddIcon = new ToolStripButton();
            TsbAddRemark = new ToolStripButton();
            TsbAddProgressBar = new ToolStripButton();
            toolStripSeparator1 = new ToolStripSeparator(); 

            // TsbAddTopic
            TsbAddTopic.DisplayStyle = ToolStripItemDisplayStyle.Image;
            TsbAddTopic.Image = Properties.Resources.threat;
            TsbAddTopic.Text = Lang._("Add Threat");
            TsbAddTopic.Click += new System.EventHandler(this.TsbAddTopic_Click);

            // TsbAddSubTopic
            TsbAddSubTopic.DisplayStyle = ToolStripItemDisplayStyle.Image;
            TsbAddSubTopic.Image = Properties.Resources.consequence;
            TsbAddSubTopic.Text = Lang._("Add Consequence");
            TsbAddSubTopic.Click += new System.EventHandler(this.TsbAddSubTopic_Click);

            // TsbAddLink
            TsbAddLink.DisplayStyle = ToolStripItemDisplayStyle.Image;
            TsbAddLink.Image = Properties.Resources.barrier;
            TsbAddLink.Text = Lang._("Add Barrier");
            TsbAddLink.Click += new System.EventHandler(this.TsbAddLink_Click);

            // TsbAddIcon
            TsbAddIcon.DisplayStyle = ToolStripItemDisplayStyle.Image;
            TsbAddIcon.Image = Properties.Resources.image;
            TsbAddIcon.Text = Lang._("Add Icon");
            TsbAddIcon.Click += new System.EventHandler(this.TsbAddIcon_Click);

            // TsbAddRemark
            TsbAddRemark.DisplayStyle = ToolStripItemDisplayStyle.Image;
            TsbAddRemark.Image = Properties.Resources.notes;
            TsbAddRemark.Text = Lang._("Add Remark");
            TsbAddRemark.Click += new System.EventHandler(this.TsbAddRemark_Click);

            // TsbAddProgressBar
            TsbAddProgressBar.DisplayStyle = ToolStripItemDisplayStyle.Image;
            TsbAddProgressBar.Image = Properties.Resources.progress_bar;
            TsbAddProgressBar.Text = Lang._("Add Progress Bar");
            TsbAddProgressBar.Click += new System.EventHandler(this.TsbAddProgressBar_Click);

            ToolStripItemsInited = true;
            ResetControlStatus();
        }

        void TsbAddTopic_Click(object sender, EventArgs e)
        {
            // AddTopic();
            AddThreat();
        }

        void TsbAddSubTopic_Click(object sender, EventArgs e)
        {
            //AddSubTopic();
            AddConsequence();
        }

        void TsbAddLink_Click(object sender, EventArgs e)
        {
            //AddLink();
            AddBarrier();
        }

        void TsbAddProgressBar_Click(object sender, EventArgs e)
        {
            AddProgressBar();
        }

        void TsbAddIcon_Click(object sender, EventArgs e)
        {
            AddIcon();
        }

        void TsbAddRemark_Click(object sender, EventArgs e)
        {
            AddRemark();
        }

        public override void ResetControlStatus()
        {
            base.ResetControlStatus();

            if (ToolStripItemsInited)
            {
                bool hasSelected = HasSelected() && SelectedTopic != null;

                TsbAddLink.Enabled = hasSelected && (SelectedTopic.Type == Model.MindMaps.TopicType.Consequence || SelectedTopic.Type == Model.MindMaps.TopicType.Threat);
                TsbAddSubTopic.Enabled = hasSelected && SelectedTopic.IsRoot;
                TsbAddTopic.Enabled = hasSelected && SelectedTopic.IsRoot;
                TsbAddIcon.Enabled = hasSelected;
                TsbAddRemark.Enabled = hasSelected;
                TsbAddProgressBar.Enabled = hasSelected;
            }
        }

        protected override void OnCurrentLanguageChanged()
        {
            base.OnCurrentLanguageChanged();

            TsbAddTopic.Text = Lang._("Add Topic", KeyMap.AddTopic.Keys);
            TsbAddSubTopic.Text = Lang._("Add Sub Topic", KeyMap.AddSubTopic.Keys);
            TsbAddLink.Text = Lang._("Add Link");
            TsbAddIcon.Text = Lang._("Add Icon");
            TsbAddProgressBar.Text = Lang._("Add Progress Bar");
            TsbAddRemark.Text = Lang._("Add Remark");
        }
    }
}
