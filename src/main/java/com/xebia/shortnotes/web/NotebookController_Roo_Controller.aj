// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.xebia.shortnotes.web;

import com.xebia.shortnotes.domain.Notebook;
import com.xebia.shortnotes.service.NotebookService;
import com.xebia.shortnotes.web.NotebookController;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect NotebookController_Roo_Controller {
    
    @Autowired
    NotebookService NotebookController.notebookService;
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String NotebookController.create(@Valid Notebook notebook, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, notebook);
            return "notebooks/create";
        }
        uiModel.asMap().clear();
        notebookService.saveNotebook(notebook);
        return "redirect:/notebooks/" + encodeUrlPathSegment(notebook.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String NotebookController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Notebook());
        return "notebooks/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String NotebookController.show(@PathVariable("id") BigInteger id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("notebook", notebookService.findNotebook(id));
        uiModel.addAttribute("itemId", id);
        return "notebooks/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String NotebookController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("notebooks", notebookService.findNotebookEntries(firstResult, sizeNo));
            float nrOfPages = (float) notebookService.countAllNotebooks() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("notebooks", notebookService.findAllNotebooks());
        }
        addDateTimeFormatPatterns(uiModel);
        return "notebooks/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String NotebookController.update(@Valid Notebook notebook, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, notebook);
            return "notebooks/update";
        }
        uiModel.asMap().clear();
        notebookService.updateNotebook(notebook);
        return "redirect:/notebooks/" + encodeUrlPathSegment(notebook.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String NotebookController.updateForm(@PathVariable("id") BigInteger id, Model uiModel) {
        populateEditForm(uiModel, notebookService.findNotebook(id));
        return "notebooks/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String NotebookController.delete(@PathVariable("id") BigInteger id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Notebook notebook = notebookService.findNotebook(id);
        notebookService.deleteNotebook(notebook);
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/notebooks";
    }
    
    void NotebookController.addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("notebook_created_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }
    
    void NotebookController.populateEditForm(Model uiModel, Notebook notebook) {
        uiModel.addAttribute("notebook", notebook);
        addDateTimeFormatPatterns(uiModel);
    }
    
    String NotebookController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}